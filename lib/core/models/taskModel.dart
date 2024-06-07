import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'nameable.dart';

class TaskModel extends Nameable {
  @override
  final String id;
  final String name;
  final String? description;
  final DateTime? startDate;
  final String? priority;
  final RxBool state;
  final DateTime? endDate;
  final String listId;

  TaskModel({
    required this.id,
    required this.name,
    this.description,
    this.startDate,
    this.priority,
    RxBool? state,
    this.endDate,
    required this.listId,
  }) : state = state ?? false.obs;

  factory TaskModel.fromDocument(DocumentSnapshot doc) {
    bool state = doc['state'];
    return TaskModel(
      id: doc.id,
      name: doc['name'],
      description: doc['description'],
      startDate: doc['startDate'].toDate(),
      priority: doc['priority'],
      state: state.obs,
      endDate: doc['endDate'].toDate(),
      listId: doc['listId'],
    );
  }

  TaskModel copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? startDate,
    String? priority,
    RxBool? state,
    DateTime? endDate,
    String? listId,
  }) {
    return TaskModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      priority: priority ?? this.priority,
      state: state ?? this.state,
      endDate: endDate ?? this.endDate,
      listId: listId ?? this.listId,
    );
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, name: $name, description: $description, startDate: $startDate, priority: $priority, state: $state, endDate: $endDate, listId: $listId)';
  }
}
