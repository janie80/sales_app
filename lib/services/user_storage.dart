import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sales_app/models/user_model.dart';

class UserStorage {
  final CollectionReference<Map<String, dynamic>> _usersCollection =
  FirebaseFirestore.instance.collection("Users");

  // Save user to Firestore
  Future<void> saveUser(UserModel user) async {
    try {
      await _usersCollection.doc(user.uid).set(user.toJson());
      if (kDebugMode) {
        print("User Saved: ${user.uid}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error Saving User: ${e.toString()}");
      }
    }
  }

  // Get user from Firestore
  Future<UserModel?> getUser(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await _usersCollection.doc(uid).get();

      if (snapshot.exists && snapshot.data() != null) {
        final data = snapshot.data();
        if (data is Map<String, dynamic>) {
          return UserModel.fromFirestore(data, uid);
        } else {
          if (kDebugMode) {
            print("Unexpected data format for user $uid: ${data.runtimeType}");
          }
          return null;
        }
      } else {
        if (kDebugMode) {
          print("User not found: $uid");
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error Getting User: ${e.toString()}");
      }
      return null;
    }
  }
}
