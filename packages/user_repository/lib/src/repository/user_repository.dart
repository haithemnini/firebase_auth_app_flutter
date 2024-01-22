import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../model/model.dart';
import './base_user_repository.dart';

class UserRepository implements BaseUserRepository {
  UserRepository([FirebaseFirestore? firebaseFirestore])
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseFirestore;

  @override
  Future<void> createUser(User user) {
    debugPrint('Creating user with id: ${user.id}');
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .set(user.toDocument());
  }

  @override
  Stream<User> getUser(String userId) {
    debugPrint('Getting user with id: $userId');
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) => User.fromSnapshot(snapshot));
  }

  @override
  Future<void> updateUser(User user) {
    debugPrint('Updating user with id: ${user.id}');
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toDocument())
        .then(
          (value) => debugPrint('User updated'),
        );
  }
}
