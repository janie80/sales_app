import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;

  UserModel({required this.uid, required this.email});

  // Factory constructor to create a UserModel from Firestore data
  factory UserModel.fromFirestore(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      email: data['email'] ?? '', // Ensure email is not null
    );
  }

  // Create UserModel from Firestore DocumentSnapshot
  factory UserModel.fromSnap(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return UserModel(
      uid: snapshot.id,
      email: data['email'] ?? '',
    );
  }

  // Convert UserModel to a Map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
    };
  }

  // Override equality and hashCode
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.uid == uid &&
        other.email == email;
  }

  @override
  int get hashCode => uid.hashCode ^ email.hashCode;

  // Override toString for better debugging
  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email)';
  }
}