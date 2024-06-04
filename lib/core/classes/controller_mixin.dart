import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remindme/core/classes/unique_controllers.dart';
import 'package:remindme/core/models/listModel.dart';

import '../models/taskModel.dart';
import '../models/user.dart';
import 'custom_colors.dart';

mixin ControllerMixin on GetxController {
  TextButton textButtonFilter(String text) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
          backgroundColor: CustomColors.darkBlue,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))),
      child: Text(
        text,
        style: TextStyle(
          color: CustomColors.mainWhite,
          fontSize: 16,
        ),
      ),
    );
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
