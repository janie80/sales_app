import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;

  UserModel({required this.uid, required this.email, required this.name});

  // Factory constructor to create a UserModel from Firestore data
  factory UserModel.fromFirestore(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
    );
  }

  // Static method to create a UserModel from a Firestore DocumentSnapshot
  static UserModel fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot.id, // Ensure UID is taken from document ID
      email: snap['email'] ?? '',
      name: snap['name'] ?? '',
    );
  }

  // Convert UserModel to a Map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }

  // Allow updating user data
  UserModel copyWith({String? name, String? email}) {
    return UserModel(
      uid: uid,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  // Override equality and hashCode
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.uid == uid &&
        other.email == email &&
        other.name == name;
  }

  @override
  int get hashCode => uid.hashCode ^ email.hashCode ^ name.hashCode;

  // Override toString for better debugging
  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, name: $name)';
  }
}
