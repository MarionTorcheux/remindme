import 'package:cloud_firestore/cloud_firestore.dart';

import 'nameable.dart';

class User extends Nameable {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc.id,
      name: doc['name'],
      email: doc['email'],
      avatarUrl: doc['avatarUrl'],
    );
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, avatarUrl: $avatarUrl)';
  }
}
