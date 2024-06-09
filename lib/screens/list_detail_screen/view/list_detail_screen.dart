import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/classes/unique_controllers.dart';
import '../../../features/custom_icon_button/view/custom_icon_button.dart';
import '../../../features/custom_space/view/custom_space.dart';
import '../../../features/screen_layout/view/screen_layout.dart';
import '../../../core/classes/custom_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../features/custom_app_bar/view/custom_app_bar.dart';
import '../../../features/custom_bottom_app_bar/view/custom_bottom_app_bar.dart';
import '../controllers/list_detail_screen_controller.dart';

class ListDetailScreen extends StatelessWidget {
  const ListDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final String listName = arguments['listName'];
    final String listImageUrl = arguments['listImageUrl'];

    ListDetailScreenController cc = Get.put(
      ListDetailScreenController(),
      tag: 'list-detail-screen',
      permanent: false,
    );

    return ScreenLayout(
      appBar: CustomAppBar(
        isLeadingWithCustomArrow: true,
        onPressed: () {
          UniquesControllers().data.isEditMode.value = false;
          cc.openBottomSheet(cc.bottomSheetTitleAddTask);
        },
        title: cc.titleListDetailScreen,
        iconData: Icons.add,
      ),
      bottomNavigationBar: CustomBottomAppBar(
        tag: cc.tagBottomAppBarListDetailScreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const CustomSpace(heightMultiplier: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                cc.textButtonFilter(0, 'Récent', () {
                  cc.lists.sort((a, b) => b.createdAt.compareTo(a.createdAt));
                }),
                cc.textButtonFilter(1, 'À faire', () {
                  cc.lists.sort((a, b) {
                    int aCount =
                        a.tasks.where((task) => !task.state.value).length;
                    int bCount =
                        b.tasks.where((task) => !task.state.value).length;
                    return aCount.compareTo(bCount);
                  });
                }),
                cc.textButtonFilter(2, 'Terminé', () {
                  ;
                  cc.lists.sort((a, b) {
                    int aCount =
                        a.tasks.where((task) => task.state.value).length;
                    int bCount =
                        b.tasks.where((task) => task.state.value).length;
                    return aCount.compareTo(bCount);
                  });
                }),
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
                    padding: const EdgeInsets.only(
                      bottom: 30,
                    ),
                    child: Text(
                      listName,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Obx(() {
                    if (cc.listTasks.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: 30,
                          ),
                          child: Text(
                            cc.textNoTask,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: cc.listTasks.asMap().entries.map((entry) {
                            int taskIndex = entry.key;
                            var task = entry.value;
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Obx(
                                      () => Column(
                                        children: [
                                          Checkbox(
                                            activeColor: CustomColors.mainBlue,
                                            value: task.state.value,
                                            onChanged: (bool? value) {
                                              task.state.value = value!;
                                              cc.updateTaskState(task);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.offNamed(Routes.taskDetail,
                                            arguments: {
                                              'task': task,
                                              'taskId': task.id,
                                              'taskName': task.name,
                                              'taskDescription':
                                                  task.description,
                                              'taskState': task.state,
                                              'endDate': task.endDate,
                                              'startDate': task.startDate,
                                              'priority': task.priority,
                                            });
                                      },
                                      child: Container(
                                        width: 180,
                                        child: Text(task.name),
                                      ),
                                    ),
                                    CustomIconButton(
                                      tag: cc.tagCustomIconButtonModifyTask,
                                      onPressed: () {
                                        UniquesControllers()
                                            .data
                                            .isEditMode
                                            .value = true;
                                        cc.openBottomSheet(
                                            cc.titleBottomSheetModifyTask);
                                      },
                                      iconData: Icons.edit,
                                      iconColor: CustomColors.darkBlue,
                                    ),
                                    CustomIconButton(
                                      tag: cc.tagCustomIconButtonDeleteTask,
                                      onPressed: () async {
                                        bool shouldDelete = await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(cc
                                                  .titleAlertDialogDeleteConfirmation),
                                              content: Text(cc
                                                  .contentAlertDialogDeleteConfirmation),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(false);
                                                  },
                                                  child: Text(
                                                      cc
                                                          .cancelAlertDialogDeleteConfirmation,
                                                      style: TextStyle(
                                                          color: CustomColors
                                                              .mainBlue)),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(true);
                                                  },
                                                  child: Text(
                                                    cc.confirmAlertDialogDeleteConfirmation,
                                                    style: TextStyle(
                                                        color: CustomColors
                                                            .interaction),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );

                                        if (shouldDelete) {
                                          bool isDeleted =
                                              await cc.deleteTask(task.id);
                                          if (isDeleted) {
                                            UniquesControllers().data.snackbar(
                                                  cc.titleSnackBarDeleteConfirmation,
                                                  cc.contentSnackBarDeleteConfirmation,
                                                  false,
                                                );
                                          }
                                        }
                                      },
                                      iconData: Icons.delete,
                                      iconColor: Colors.red,
                                    ),
                                  ],
                                ),
                                if (taskIndex < cc.listTasks.length - 1)
                                  const Divider(
                                    color: Colors.grey,
                                    indent: 40,
                                    endIndent: 40,
                                  ),
                              ],
                            );
                          }).toList(),
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
