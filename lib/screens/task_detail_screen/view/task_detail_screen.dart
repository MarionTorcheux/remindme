import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remindme/features/custom_app_bar/view/custom_app_bar.dart';
import 'package:remindme/features/screen_layout/view/screen_layout.dart';
import '../../../../../core/classes/custom_colors.dart';
import '../../../../../features/custom_bottom_app_bar/view/custom_bottom_app_bar.dart';
import '../../../../../features/custom_space/view/custom_space.dart';
import '../../../features/custom_fab_button/view/custom_fab_button.dart';
import '../controllers/task_detail_screen_controller.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final task = arguments['task'];
    final String taskId = arguments['taskId'];
    final String taskName = arguments['taskName'];
    final String taskDescription = arguments['taskDescription'];
    final RxBool taskState = arguments['taskState'];
    final DateTime startDate = arguments['startDate'];
    final DateTime endDate = arguments['endDate'];
    final String priority = arguments['priority'];

    TaskDetailScreenController cc = Get.put(
      TaskDetailScreenController(),
      tag: 'task_detail_screen',
      permanent: true,
    );

    return ScreenLayout(
      appBar: CustomAppBar(
        title: 'Détails de la tâche',
        onPressed: () {},
        iconData: Icons.edit,
        isLeadingWithCustomArrow: true,
      ),
      bottomNavigationBar: CustomBottomAppBar(
        tag: "bottomAppBar",
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Obx(
                () => Column(
                  children: [
                    CustomSpace(heightMultiplier: 4),
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        width: 320.0,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Container(
                              width: 280.0,
                              child: Row(
                                children: [
                                  Checkbox(
                                    activeColor: CustomColors.mainBlue,
                                    value: taskState.value,
                                    onChanged: (bool? value) {
                                      taskState.value = value!;
                                      cc.updateTaskState(task);
                                    },
                                  ),
                                  Container(
                                    width: 200.0,
                                    child: Text(
                                      taskName,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomSpace(heightMultiplier: 0.05),
                            Text(
                              taskDescription,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            CustomSpace(heightMultiplier: 0.05),
                            Text(
                              'Date de début: ${startDate.day}/${startDate.month}/${startDate.year}',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            CustomSpace(heightMultiplier: 0.05),
                            Text(
                              'Date de fin: ${endDate.day}/${endDate.month}/${endDate.year}',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            CustomSpace(heightMultiplier: 0.05),
                            Text(
                              'Priorité: $priority',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            CustomSpace(heightMultiplier: 0.05),
                          ],
                        ),
                      ),
                    ),
                    CustomSpace(heightMultiplier: 3.0),
                    Container(
                      width: 320.0,
                      child: CustomFABButton(
                        text: 'Supprimer',
                        onPressed: () {},
                        tag: 'deleteButton',
                        backgroundColor: CustomColors.interaction,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
