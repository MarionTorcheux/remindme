import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/classes/controller_mixin.dart';
import '../../../core/classes/custom_colors.dart';
import '../../../core/classes/unique_controllers.dart';
import '../../../core/models/taskModel.dart';
import '../../../features/custom_fab_button/view/custom_fab_button.dart';
import '../../../features/custom_icon_button/view/custom_icon_button.dart';
import '../../../features/custom_space/view/custom_space.dart';
import '../../../features/custom_text_form_field/view/custom_text_form_field.dart';
import 'date_picker_controller.dart';

class ListDetailScreenController extends GetxController with ControllerMixin {
  String bottomSheetTitleAddTask = 'Ajouter une tâche';
  String titleListDetailScreen = 'Détails de la liste';
  String tagBottomAppBarListDetailScreen = 'bottom-app-bar-list-detail-screen';
  String textNoTask = 'Aucune tâche dans cette liste.';
  String tagCustomIconButtonModifyTask = 'modify-task';
  String titleBottomSheetModifyTask = 'Modifier la tâche';
  String tagCustomIconButtonDeleteTask = 'delete-task';
  String titleAlertDialogDeleteConfirmation = 'Confirmation';
  String contentAlertDialogDeleteConfirmation =
      'Voulez-vous vraiment supprimer cette tâche ?';
  String cancelAlertDialogDeleteConfirmation = 'Retour';
  String confirmAlertDialogDeleteConfirmation = 'Confirmer';
  String titleSnackBarDeleteConfirmation = 'Tâche supprimée';
  String contentSnackBarDeleteConfirmation =
      'La tâche a été supprimée avec succès.';

  late RxString listId = ''.obs;
  var listTasks = <TaskModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    if (arguments.containsKey('listId')) {
      listId.value = arguments['listId'];
      listTasks.value = arguments['listTasks'];
    }
  }

  final DatePickerController datePickerController =
      Get.put(DatePickerController());
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String selectedValue = 'urgent';
  final List<String> items = ['urgent', 'moyen', 'faible'];
  var selectedDate = DateTime.now().obs;

  Future<TaskModel?> addNewTask() async {
    TaskModel? newTask = null;

    try {
      var docRef = await UniquesControllers()
          .data
          .firebaseFirestore
          .collection('task')
          .add({
        'name': nameController.text,
        'description': descriptionController.text,
        'listId': listId.value,
        'state': false,
        'priority': selectedValue,
        'startDate': DateTime.now(),
        'endDate': selectedDate.value,
      });

      print('List ID on task creation: $listId');

      newTask = TaskModel(
        name: nameController.text,
        description: descriptionController.text,
        listId: listId.value,
        id: docRef.id,
        state: false.obs,
        priority: selectedValue,
        startDate: DateTime.now(),
        endDate: selectedDate.value,
      );
    } catch (e) {
      UniquesControllers().data.snackbar('Erreur', e.toString(), true);
    }
    return newTask;
  }

  Future<bool> deleteTask(String taskId) async {
    try {
      await UniquesControllers()
          .data
          .firebaseFirestore
          .collection('task')
          .doc(taskId)
          .delete();
      listTasks.removeWhere((task) => task.id == taskId);
      return true;
    } catch (e) {
      return false;
    }
  }

  deleteBottomSheet() {}

  actionBottomSheet() async {}

  void openBottomSheet(
    String title, {
    bool? hasDeleteButton,
    bool? hasAction,
    String? actionName,
    IconData? actionIcon,
  }) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: CustomColors.mainWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(UniquesControllers().data.baseSpace * 2),
              topRight:
                  Radius.circular(UniquesControllers().data.baseSpace * 2),
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: UniquesControllers().data.baseSpace,
                      left: UniquesControllers().data.baseSpace,
                    ),
                    child: CustomIconButton(
                      tag: 'bottom-sheet-back-button',
                      iconData: Icons.arrow_back_rounded,
                      onPressed: () {
                        UniquesControllers().data.back();
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Visibility(
                    visible: hasDeleteButton ?? false,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: UniquesControllers().data.baseSpace,
                        right: UniquesControllers().data.baseSpace,
                      ),
                      child: CustomIconButton(
                        tag: 'bottom-sheet-delete-button',
                        iconData: Icons.delete_rounded,
                        onPressed: () {
                          UniquesControllers().data.back();
                        },
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 300.0,
                    child: Column(
                      children: [
                        const CustomSpace(heightMultiplier: 2.4),
                        Center(
                          child: Text(
                            title,
                          ),
                        ),
                        const CustomSpace(heightMultiplier: 4),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: UniquesControllers().data.baseSpace * 4,
                          ),
                        ),
                        CustomTextFormField(
                          tag: 'nameTask',
                          controller: nameController,
                          labelText: 'Titre de la tâche',
                          labelTextColor: CustomColors.mainBlue,
                        ),
                        const CustomSpace(heightMultiplier: 3),
                        CustomTextFormField(
                          minLines: 3,
                          maxLines: 10,
                          tag: 'descriptionTask',
                          controller: descriptionController,
                          labelText: 'Description de la tâche',
                          labelTextColor: CustomColors.mainBlue,
                        ),
                        const CustomSpace(heightMultiplier: 3),
                        PhysicalModel(
                          color: CustomColors.mainWhite,
                          borderRadius: BorderRadius.circular(10),
                          elevation: 3.0,
                          shadowColor: Colors.black,
                          child: Container(
                            width: 300.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: InputDecorator(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                border: InputBorder.none,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedValue,
                                  elevation: 16,
                                  style: TextStyle(
                                      color: CustomColors.mainBlue,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                  items: items.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    selectedValue = newValue!;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        const CustomSpace(heightMultiplier: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date de début :  ',
                              style: TextStyle(
                                color: CustomColors.mainBlue,
                                fontSize: 13,
                              ),
                            ),
                            Obx(
                              () => SizedBox(
                                width: 160.0,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: CustomColors.darkBlue,
                                    backgroundColor: CustomColors.mainWhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                  ),
                                  onPressed: () => datePickerController
                                      .selectDate(Get.context!),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${_formatDate(datePickerController.selectedDate.value)}',
                                        style: TextStyle(
                                          color: CustomColors.darkBlue,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Icon(Icons.calendar_month,
                                          color: CustomColors.darkBlue),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date de fin :  ',
                              style: TextStyle(
                                color: CustomColors.mainBlue,
                                fontSize: 13,
                              ),
                            ),
                            Obx(
                              () => SizedBox(
                                width: 160.0,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: CustomColors.darkBlue,
                                    backgroundColor: CustomColors.mainWhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                  ),
                                  onPressed: () => datePickerController
                                      .selectDate(Get.context!),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${_formatDate(datePickerController.selectedDate.value)}',
                                        style: TextStyle(
                                          color: CustomColors.darkBlue,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Icon(Icons.calendar_month,
                                          color: CustomColors.darkBlue),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const CustomSpace(heightMultiplier: 2),
                        Visibility(
                          visible: hasAction ?? true,
                          child: const CustomSpace(heightMultiplier: 2),
                        ),
                        Obx(
                          () => Visibility(
                            visible: hasAction ?? true,
                            child: CustomFABButton(
                              tag: 'action-bottom-sheet-button2',
                              text:
                                  UniquesControllers().data.isEditMode.value ==
                                          true
                                      ? 'Modifier'
                                      : 'Créer',
                              onPressed: () async {
                                TaskModel? newTask = await addNewTask();
                                if (newTask != null) {
                                  listTasks.add(newTask);
                                  nameController.clear();
                                  descriptionController.clear();
                                }
                                UniquesControllers().data.back();
                              },
                              backgroundColor: CustomColors.mainBlue,
                            ),
                          ),
                        ),
                        const CustomSpace(heightMultiplier: 2),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  String _formatDate(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();
    return '$day/$month/$year';
  }
}
