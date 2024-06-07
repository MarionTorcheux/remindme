import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remindme/core/models/taskModel.dart';
import 'package:remindme/features/custom_text_form_field/view/custom_text_form_field.dart';

import '../../../core/classes/controller_mixin.dart';
import '../../../core/classes/custom_colors.dart';
import '../../../core/classes/unique_controllers.dart';
import '../../../core/models/listModel.dart';
import '../../../core/routes/app_routes.dart';
import '../../../features/custom_fab_button/view/custom_fab_button.dart';
import '../../../features/custom_icon_button/view/custom_icon_button.dart';
import '../../../features/custom_space/view/custom_space.dart';

class ListsScreenController extends GetxController with ControllerMixin {
  FirebaseFirestore firestore = UniquesControllers().data.firebaseFirestore;
  RxString selectedImagePath = ''.obs;
  TextEditingController nameController = TextEditingController();
  RxInt selectedListIndex = 0.obs;

  Future<String> uploadImage(File file, String userId) async {
    final List<Future<String>> uploadTasks = [];
    String url = '';
    List<String> imageListLocalPath = <String>[];
    try {
      imageListLocalPath.add(file.path);

      final fileName = path.basename(file.path);
      final destination = '$destinationStorage/$userId/$fileName';

      final uploadTask = firebaseStorage.ref(destination).putFile(file);
      uploadTasks.add(uploadTask.then((taskSnapshot) async {
        final downloadUrl = await taskSnapshot.ref.getDownloadURL();

        url = downloadUrl;
        return downloadUrl;
      }));

      await Future.wait(uploadTasks);
    } catch (e) {
      UniquesControllers()
          .data
          .snackbar('Erreur lors de l\'upload de l\'image', e.toString(), true);
    }
    return url;
  }

  //TODO SELECTION DE L'IMAGE DE LA LISTE
  String deleteImageTag = 'delete-image';
  String destinationStorage = 'pictureList';
  final firebaseStorage = FirebaseStorage.instance;
  RxBool isPickedFile = false.obs;
  File file = File('');

  void pickFiles() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        String imagePath = result.files.single.path ?? '';

        selectedImagePath.value = imagePath;
      } else {}

      if (result != null) {
        if (result.files.single.path != null) {
          file = File(result.files.single.path!);
          isPickedFile.value = false;

          isPickedFile.value = true;
        }
      }
    } catch (e) {
      print('Erreur lors de la sélection de fichier : $e');
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
                        onPressed: deleteBottomSheet,
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
                          tag: 'titleListInputField',
                          controller: nameController,
                          labelText: 'Titre de la liste',
                          labelTextColor: CustomColors.mainBlue,
                        ),
                        const CustomSpace(heightMultiplier: 2),
                        Obx(
                          () => InkWell(
                            onTap: () {
                              pickFiles();
                            },
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 280,
                                maxHeight: 90,
                                minHeight: 90,
                              ),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    selectedImagePath.value.isNotEmpty
                                        ? CustomIconButton(
                                            tag: deleteImageTag,
                                            iconData: Icons.delete,
                                            iconColor: Colors.red,
                                            backgroundColor: Colors.white,
                                            onPressed: () {
                                              selectedImagePath.value = '';
                                              file = File('');
                                            },
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(
                                                Icons.add_a_photo,
                                                color: CustomColors.mainBlue,
                                              ),
                                              CustomSpace(widthMultiplier: 2),
                                              Text(
                                                'Ajouter une image',
                                                style: TextStyle(
                                                  color: CustomColors.mainBlue,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                width: 280,
                                height: 50,
                                decoration: BoxDecoration(
                                  image: selectedImagePath.value.isNotEmpty
                                      ? DecorationImage(
                                          image: UniquesControllers()
                                                  .data
                                                  .isEditMode
                                                  .value
                                              ? NetworkImage(
                                                  lists[selectedListIndex.value]
                                                      .imageUrl)
                                              : FileImage(File(
                                                      selectedImagePath.value))
                                                  as ImageProvider,
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                  borderRadius: BorderRadius.circular(
                                      UniquesControllers().data.baseSpace),
                                  boxShadow: [
                                    BoxShadow(
                                      color: CustomColors.mainBlue
                                          .withOpacity(0.1),
                                      blurRadius:
                                          UniquesControllers().data.baseSpace,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: hasAction ?? true,
                          child: const CustomSpace(heightMultiplier: 2),
                        ),
                        Obx(
                          () => Visibility(
                            visible: hasAction ?? true,
                            child: CustomFABButton(
                              tag: 'action-bottom-sheet-button',
                              text:
                                  UniquesControllers().data.isEditMode.value ==
                                          true
                                      ? 'Modifier'
                                      : 'Créer',
                              onPressed: () async {
                                if (UniquesControllers()
                                    .data
                                    .isEditMode
                                    .value) {
                                  ListModel? newList = await modifyList(
                                      lists[selectedListIndex.value].imageUrl);
                                  if (newList != null) {
                                    int index = lists.indexWhere((element) =>
                                        element.id ==
                                        UniquesControllers()
                                            .data
                                            .selectedListId!
                                            .value);

                                    lists[index] = newList;
                                  }
                                  UniquesControllers().data.cleanListVar();
                                } else {
                                  ListModel? newList = await addNewList();
                                  if (newList != null) {
                                    lists.add(newList);
                                  }
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

  Future<ListModel?> addNewList() async {
    String defaultListImage =
        "https://firebasestorage.googleapis.com/v0/b/remindme-dc6a8.appspot.com/o/pictureList%2FdefaultListImage.png?alt=media&token=3c2a78db-1114-4166-864f-95c21a8abd90";

    String imageUrl = '';

    if (file.path != '') {
      imageUrl = await uploadImage(
          file, UniquesControllers().getStorage.read('currentUserUID'));
    } else {
      imageUrl = defaultListImage;
    }

    ListModel? newList = null;

    try {
      var docRef = await UniquesControllers()
          .data
          .firebaseFirestore
          .collection('list')
          .add({
        'name': nameController.text,
        'userId': UniquesControllers().getStorage.read('currentUserUID'),
        'createdAt': DateTime.now(),
        'imageUrl': imageUrl
      });

      // Récupérer l'ID du document créé
      String docId = docRef.id;

      newList = ListModel(
        name: nameController.text,
        userId: UniquesControllers().getStorage.read('currentUserUID'),
        createdAt: DateTime.now(),
        imageUrl: imageUrl,
        tasks: [],
        id: docId,
      );
      selectedImagePath.value = '';
      file = File('');
      nameController.clear();
    } catch (e) {
      UniquesControllers().data.snackbar('Erreur', e.toString(), true);
    }
    return newList;
  }

  Future<ListModel?> modifyList(String imageUrlList) async {
    print('image url listtttttttttttttttttttttttt : $imageUrlList');

    String defaultListImage =
        "https://firebasestorage.googleapis.com/v0/b/remindme-dc6a8.appspot.com/o/pictureList%2FdefaultListImage.png?alt=media&token=3c2a78db-1114-4166-864f-95c21a8abd90";
    String imageUrl = imageUrlList; // Utiliser l'image URL existante par défaut

    // Si l'image a été réinitialisée (via la suppression)
    if (selectedImagePath.value == '' && file.path == '') {
      imageUrl = defaultListImage;
    } else if (file.path != '') {
      // Si un nouveau fichier a été sélectionné, téléchargez-le
      imageUrl = await uploadImage(
          file, UniquesControllers().getStorage.read('currentUserUID'));
    }

    ListModel? newList;

    try {
      await UniquesControllers()
          .data
          .firebaseFirestore
          .collection('list')
          .doc(lists[selectedListIndex.value].id)
          .set({
        'name': nameController.text,
        'userId': UniquesControllers().getStorage.read('currentUserUID'),
        'createdAt': DateTime.now(),
        'imageUrl': imageUrl
      }, SetOptions(merge: true));

      newList = ListModel(
        name: nameController.text,
        userId: UniquesControllers().getStorage.read('currentUserUID'),
        createdAt: DateTime.now(),
        imageUrl: imageUrl,
        tasks: lists[selectedListIndex.value].tasks,
        id: lists[selectedListIndex.value].id,
      );

      file = File('');
      nameController.clear();
      selectedImagePath.value = '';
    } catch (e) {
      UniquesControllers().data.snackbar('Erreur', e.toString(), true);
    }

    return newList;
  }

  Future<bool> deleteList(String listId) async {
    bool isDeleted = false;
    try {
      QuerySnapshot taskSnapshot = await firestore
          .collection('task')
          .where('listId', isEqualTo: listId)
          .get();

      for (QueryDocumentSnapshot doc in taskSnapshot.docs) {
        await firestore.collection('task').doc(doc.id).delete();
      }

      await firestore.collection('list').doc(listId).delete();

      print("List and its tasks deleted successfully");
      isDeleted = true;
    } catch (error) {
      print("Failed to delete list: $error");
    }

    return isDeleted;
  }
}
