import 'package:get/get.dart';

import '../../../core/classes/controller_mixin.dart';
import '../../../core/classes/unique_controllers.dart';
import '../../../core/models/taskModel.dart';

class TaskDetailScreenController extends GetxController with ControllerMixin {
  var listTasks = <TaskModel>[].obs;
  late RxString listId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    if (arguments.containsKey('listId')) {
      listId.value = arguments['listId'];
      listTasks.value = arguments['listTasks'];
    }
  }

  String titlePage = 'Détails de la tâche';
  String tagBottomAppBarTaskDetailScreen = 'bottomAppBarTaskDetailScreen';

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
}
