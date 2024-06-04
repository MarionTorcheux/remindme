import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remindme/features/custom_icon_button/view/custom_icon_button.dart';
import 'package:remindme/features/custom_space/view/custom_space.dart';
import 'package:remindme/features/screen_layout/view/screen_layout.dart';
import '../../../core/classes/custom_colors.dart';
import '../../../core/routes/app_routes.dart';
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
          'Détails de la liste',
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
                      padding: const EdgeInsets.only(
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
                            padding: const EdgeInsets.only(
                              bottom: 30,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: listTasks.asMap().entries.map((entry) {
                                int taskIndex = entry.key;
                                var task = entry.value;
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Obx(
                                          () => Checkbox(
                                            activeColor: CustomColors.mainBlue,
                                            value: task.state.value,
                                            onChanged: (bool? value) {
                                              task.state.value = value!;
                                              cc.updateTaskState(task);
                                            },
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(Routes.taskDetail,
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
                                            width: 240,
                                            child: Text(task.name),
                                          ),
                                        ),
                                        CustomIconButton(
                                          tag: 'modify-task',
                                          onPressed: () {},
                                          iconData: Icons.edit,
                                        ),
                                        CustomIconButton(
                                          tag: 'delete-task',
                                          onPressed: () {
                                            print('delete');
                                          },
                                          iconData: Icons.delete,
                                          iconColor: Colors.red,
                                        ),
                                      ],
                                    ),
                                    if (taskIndex < listTasks.length - 1)
                                      const Divider(
                                        color: Colors.grey,
                                        indent: 40,
                                        endIndent: 40,
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
