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
                                border: InputBorder.none,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedValue,
                                  elevation: 16,
                                  style: TextStyle(
                                      color: CustomColors.mainBlue,
                                      fontSize: 16),
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
                        Obx(() => Text(
                              'Date sélectionnée : ${datePickerController.selectedDate.value.toLocal()}'
                                  .split(' ')[0],
                            )),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () =>
                              datePickerController.selectDate(Get.context!),
                          child: Text('Sélectionner une date'),
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
}
