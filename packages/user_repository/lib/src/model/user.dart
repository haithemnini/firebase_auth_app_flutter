import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String email;
  final String fullName;
  final String? photoUrl;

  const User({
    this.id,
    this.email = '',
    this.fullName = '',
    this.photoUrl,
  });

  User copyWith({
    String? id,
    String? email,
    String? fullName,
    String? photoUrl,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    return User(
      id: snapshot.id,
      email: snapshot['email'],
      fullName: snapshot['fullName'],
      photoUrl: snapshot['photoUrl'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'email': email,
      'fullName': fullName,
      'photoUrl': photoUrl,
    };
  }

  @override
  List<Object?> get props => [id, email, fullName, photoUrl];
}
