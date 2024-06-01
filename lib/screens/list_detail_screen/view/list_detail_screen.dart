import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remindme/features/custom_space/view/custom_space.dart';
import 'package:remindme/features/screen_layout/view/screen_layout.dart';
import '../../../core/classes/custom_colors.dart';
import '../../../features/custom_bottom_app_bar/view/custom_bottom_app_bar.dart';
import '../controllers/list_detail_screen_controller.dart';

class ListDetailScreen extends StatelessWidget {
  const ListDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final String listId = arguments['listId'];
    final String listName = arguments['listName'];
    final List listTasks = arguments['listTasks'];
    final String listImageUrl = arguments['listImageUrl'];

    ListDetailScreenController cc = Get.put(
      ListDetailScreenController(),
      tag: 'list-detail-screen',
      permanent: true,
    );

    return ScreenLayout(
      appBar: AppBar(
        title: const Text(
          'Detail',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Get.toNamed(AppRoutes.addTask);
            },
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(
        tag: "bottomAppBar",
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: CustomColors.backgroundGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
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
              Card(
                child: Column(
                  children: [
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(listImageUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),
                    CustomSpace(heightMultiplier: 2),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 30,
                      ),
                      child: Text(
                        listName,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    listTasks.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: 30,
                              ),
                              child: Text(
                                'Aucune tâche dans cette liste.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                              bottom: 30,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: listTasks.map((task) {
                                return Row(
                                  children: [
                                    Obx(
                                      () => Row(
                                        children: [
                                          Checkbox(
                                            activeColor: CustomColors.mainBlue,
                                            value: task.state.value,
                                            onChanged: (bool? value) {
                                              task.state.value = value!;
                                              cc.updateTaskState(task);
                                            },
                                          ),
                                          Container(
                                            width: 290,
                                            child: Text(task.name),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
