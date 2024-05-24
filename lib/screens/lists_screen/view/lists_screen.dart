import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remindme/core/models/taskModel.dart';
import 'package:remindme/features/custom_app_bar/view/custom_app_bar.dart';
import 'package:remindme/features/custom_space/view/custom_space.dart';

import '../../../core/classes/custom_colors.dart';
import '../../../core/classes/unique_controllers.dart';
import '../../../core/routes/app_routes.dart';
import '../../../features/custom_bottom_app_bar/view/custom_bottom_app_bar.dart';
import '../../../features/screen_layout/view/screen_layout.dart';
import '../controllers/lists_screen_controller.dart';

class ListsScreen extends StatelessWidget {
  const ListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ListsScreenController cc = Get.put(
      ListsScreenController(),
      tag: 'lists_screen',
      permanent: true,
    );

    cc.getLists();

    return ScreenLayout(
      appBar: CustomAppBar(
        title: 'Mes listes',
        onPressed: () {},
        isautomaticallyImplyLeading: false,
        iconData: Icons.add,
      ),
      bottomNavigationBar: CustomBottomAppBar(
        tag: "bottomAppBar",
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: CustomColors.backgroundGradient,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    cc.textButtonFilter('Récent'),
                    cc.textButtonFilter('À faire'),
                    cc.textButtonFilter('Terminé'),
                  ],
                ),
                CustomSpace(heightMultiplier: 2),
                Expanded(
                  child: Obx(
                    () {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.75, // Adjust ratio as needed
                        ),
                        itemCount: cc.lists.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // Your onTap function here
                              // For example, navigate to detail screen or show a dialog
                              print('Card tapped: ${cc.lists[index].id}');
                              print('${cc.lists[index].tasks}');
                              Get.toNamed(Routes.listDetail, arguments: {
                                'listId': cc.lists[index].id,
                                'listName': cc.lists[index].name,
                                'listImageUrl': cc.lists[index].imageUrl,
                                'listTasks': cc.lists[index].tasks,
                                'taskState': cc.lists[index].tasks,
                              });
                            },
                            child: Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          cc.lists[index].imageUrl,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  CustomSpace(heightMultiplier: 2),
                                  Center(
                                    child: Text(
                                      cc.lists[index].name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children:
                                          cc.lists[index].tasks.map((task) {
                                        return Row(
                                          children: [
                                            Obx(
                                              () => Checkbox(
                                                activeColor:
                                                    CustomColors.mainBlue,
                                                value: task.state.value,
                                                onChanged: (bool? value) {
                                                  task.state.value = value!;
                                                  cc.updateTaskState(task);
                                                },
                                              ),
                                            ),
                                            Text(task.name),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
