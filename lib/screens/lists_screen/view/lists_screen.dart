import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        onPressed: () {
          cc.nameController.clear();
          cc.openBottomSheet("Ajouter une liste");
        },
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
                          childAspectRatio: 0.60,
                        ),
                        itemCount: cc.lists.length,
                        itemBuilder: (context, index) {
                          final list = cc.lists[index];
                          return InkWell(
                            onTap: () {
                              print('Card tapped: ${list.id}');
                              print('${list.tasks}');
                              Get.toNamed(Routes.listDetail, arguments: {
                                'listId': list.id,
                                'listName': list.name,
                                'listImageUrl': list.imageUrl,
                                'listTasks': list.tasks,
                                'taskState': list.tasks,
                              });
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
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: list.tasks.map((task) {
                                              return Row(
                                                children: [
                                                  Obx(
                                                    () => Checkbox(
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
                                                  ),
                                                  Text(task.name),
                                                ],
                                              );
                                            }).toList(),
                                          )
                                        : const Center(
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
                                  ),
                                  const Spacer(),
                                  Center(
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            UniquesControllers()
                                                .data
                                                .isEditMode
                                                .value = true;

                                            UniquesControllers()
                                                .data
                                                .selectedListId
                                                ?.value = list.id;
                                            cc.nameController.text = list.name;
                                            cc.openBottomSheet(
                                              "Modifier la liste",
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () async {
                                            bool shouldDelete =
                                                await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Confirmation'),
                                                  content: const Text(
                                                      'Êtes-vous sûr de vouloir supprimer cette liste?'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(false);
                                                      },
                                                      child: Text('Retour',
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
                                                      child: const Text(
                                                        'Confirmer',
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
                                                      'Liste supprimée',
                                                      'La liste a été supprimée avec succès',
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
