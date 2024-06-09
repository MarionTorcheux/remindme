import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'unique_controllers.dart';
import '../models/listModel.dart';
import '../models/taskModel.dart';
import '../models/user.dart';
import 'custom_colors.dart';

mixin ControllerMixin on GetxController {
  List<RxBool> filterButtonStates = List.generate(3, (index) => false.obs);

  Widget textButtonFilter(int index, String text, Function() onPressed) {
    return Obx(() => TextButton(
          onPressed: () {
            onPressed();
            filterButtonStates[index].value = !filterButtonStates[index].value;

            for (int i = 0; i < filterButtonStates.length; i++) {
              if (i != index) {
                filterButtonStates[i].value = false;
              }
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: filterButtonStates[index].value
                ? CustomColors.mainBlue
                : CustomColors.darkBlue,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: CustomColors.mainWhite,
              fontSize: 16,
            ),
          ),
        ));
  }

  //#region users

  Rx<User?> currentUser = Rx<User?>(null);

  Stream<User> getCurrentUser() {
    String? userId = UniquesControllers().getStorage.read('currentUserUID');
    return UniquesControllers()
        .data
        .firebaseFirestore
        .collection('user')
        .doc(userId)
        .snapshots()
        .map((doc) => User.fromDocument(doc));
  }

  Stream<String?> avatarUrlStream(User user) async* {
    yield user.avatarUrl;
  }

  //#endregion

//# region lists

  RxList<ListModel> lists = <ListModel>[].obs;
  Rx<ListModel> selectedCurrentList = ListModel(
    id: '',
    name: '',
    imageUrl: '',
    createdAt: DateTime(0),
    userId: '',
    tasks: [],
  ).obs;

  void getLists() async {
    String? userId = UniquesControllers().getStorage.read('currentUserUID');
    if (userId != null) {
      try {
        final querySnapshotList = await UniquesControllers()
            .data
            .firebaseFirestore
            .collection('list')
            .where('userId', isEqualTo: userId)
            .get();

        List<ListModel> tempLists = [];
        for (var doc in querySnapshotList.docs) {
          final querySnapshotTask = await UniquesControllers()
              .data
              .firebaseFirestore
              .collection('task')
              .where('listId', isEqualTo: doc.id)
              .get();
          List<TaskModel> tasks = querySnapshotTask.docs
              .map((docTask) => TaskModel.fromDocument(docTask))
              .toList();

          tempLists.add(ListModel.fromDocument(doc, tasks));
        }

        lists.value = tempLists;
      } catch (error) {
        print("Failed to get lists: $error");
        lists.clear();
      }
    } else {
      lists.clear();
    }
  }

  void updateTaskState(TaskModel task) async {
    try {
      await UniquesControllers()
          .data
          .firebaseFirestore
          .collection('task')
          .doc(task.id)
          .update({'state': task.state.value});
    } catch (error) {
      print("Failed to update task state: $error");
    }
  }

//# endregion
}
