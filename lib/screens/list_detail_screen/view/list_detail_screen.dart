import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:remindme/features/custom_text_button/view/custom_text_button.dart';
import 'package:remindme/features/screen_layout/view/screen_layout.dart';
import '../../../core/classes/custom_colors.dart';
import '../../../core/classes/unique_controllers.dart';
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
              // Get.toNamed(AppRoutes.addList);
            },
          ),
        ],
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
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Card(
              child: Column(
                children: [
                  Text(
                    listName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.network(
                    listImageUrl,
                    width: 200,
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                  Text(task.name),
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
          ])
        ],
      ),
    );
  }
}
