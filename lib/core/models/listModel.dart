import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:remindme/core/models/taskModel.dart';

import 'nameable.dart';

class ListModel extends Nameable {
  @override
  final String id;
  final String name;
  final String imageUrl;
  final DateTime createdAt;
  final String userId;
  late final List<TaskModel> tasks;

  ListModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.createdAt,
    required this.userId,
    required this.tasks,
  });

  factory ListModel.fromDocument(DocumentSnapshot doc, List<TaskModel> tasks) {
    return ListModel(
      id: doc.id,
      name: doc['name'],
      imageUrl: doc['imageUrl'],
      createdAt: doc['createdAt'].toDate(),
      userId: doc['userId'],
      tasks: tasks,
    );
  }

  ListModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    DateTime? createdAt,
    String? userId,
  }) {
    return ListModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      tasks: tasks,
    );
  }

  @override
  String toString() {
    return 'ListModel(id: $id, name: $name, imageUrl: $imageUrl, createdAt: $createdAt, userId: $userId, tasks: $tasks)';
  }
}
