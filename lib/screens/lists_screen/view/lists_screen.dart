import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/custom_app_bar/view/custom_app_bar.dart';
import '../../../features/custom_space/view/custom_space.dart';
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
        title: cc.titleListsScreen,
        onPressed: () {
          cc.nameController.clear();
          cc.selectedImagePath.value = '';
          cc.openBottomSheet(cc.titleBottomSheetAddList);
        },
        iconData: Icons.add,
      ),
      bottomNavigationBar: CustomBottomAppBar(
        tag: cc.tagBottomAppBarListsScreen,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const CustomSpace(heightMultiplier: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    cc.textButtonFilter(0, 'Récent', () {
                      cc.lists
                          .sort((a, b) => b.createdAt.compareTo(a.createdAt));
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
                Expanded(
                  child: Obx(
                    () {
                      if (cc.lists.isEmpty) {
                        return Center(
                          child: Text(cc.textNoLists,
                              style: Theme.of(context).textTheme.headlineSmall,
                              textAlign: TextAlign.center),
                        );
                      }
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.50,
                        ),
                        itemCount: cc.lists.length,
                        itemBuilder: (context, index) {
                          final list = cc.lists[index];
                          return InkWell(
                            onTap: () {
                              Get.toNamed(Routes.listDetail, arguments: {
                                'listId': list.id,
                                'listName': list.name,
                                'listImageUrl': list.imageUrl,
                                'listTasks': list.tasks,
                                'taskState': list.tasks,
                              });
                              print('Card tapped: ${list.id}');
                            },
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(list.imageUrl),
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
                                      list.name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: list.tasks.isNotEmpty
                                        ? Obx(
                                            () => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: list.tasks
                                                  .take(3)
                                                  .map((task) {
                                                return Row(
                                                  children: [
                                                    Checkbox(
                                                      activeColor:
                                                          CustomColors.mainBlue,
                                                      value: task.state.value,
                                                      onChanged: (bool? value) {
                                                        task.state.value =
                                                            value!;
                                                        cc.updateTaskState(
                                                            task);
                                                      },
                                                    ),
                                                    Flexible(
                                                      child: Container(
                                                        child: Text(
                                                          task.name,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }).toList(),
                                            ),
                                          )
                                        : Center(
                                            child: Text(
                                              cc.textNoTaskInList,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                  ),
                                  const Spacer(),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            cc.selectedListIndex.value = index;
                                            UniquesControllers()
                                                .data
                                                .isEditMode
                                                .value = true;
                                            UniquesControllers()
                                                .data
                                                .selectedListId
                                                ?.value = list.id;
                                            cc.nameController.text = list.name;
                                            cc.selectedImagePath.value =
                                                list.imageUrl;
                                            cc.openBottomSheet(
                                              cc.titleBottomSheetModifyList,
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () async {
                                            bool shouldDelete =
                                                await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      cc.textTitleDeleteList),
                                                  content: Text(
                                                      cc.textContentDeleteList),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(false);
                                                      },
                                                      child: Text(
                                                          cc.textActionCancelList,
                                                          style: TextStyle(
                                                            color: CustomColors
                                                                .mainBlue,
                                                          )),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(true);
                                                      },
                                                      child: Text(
                                                        cc.textActionDeleteList,
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
                                                  await cc.deleteList(list.id);
                                              if (isDeleted) {
                                                cc.lists.remove(list);
                                                UniquesControllers()
                                                    .data
                                                    .snackbar(
                                                      cc.titleSnackBarConfimation,
                                                      cc.textSnackBarConfimation,
                                                      false,
                                                    );
                                              }
                                            }
                                          },
                                        ),
                                      ],
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
