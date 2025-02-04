import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_app/models/user_model.dart';

class UserStorage {
  final CollectionReference<Map<String, dynamic>> _usersCollection =
  FirebaseFirestore.instance.collection("Users");

  // Save user to Firestore
  Future<void> saveUser(UserModel user) async {
    try {
      await _usersCollection.doc(user.uid).set(user.toJson());
      print("User Saved: ${user.uid}");
    } catch (e) {
      print("Error Saving User: ${e.toString()}");
    }
  }

  // Get user from Firestore
  Future<UserModel?> getUser(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await _usersCollection.doc(uid).get();
      if (snapshot.exists) {
        return UserModel.fromSnap(snapshot);
      } else {
        print("User not found: $uid");
        return null;
      }
    } catch (e) {
      print("Error Getting User: ${e.toString()}");
      return null;
    }
  }

  // Update user's email in Firestore
  Future<bool> updateUserEmail(String uid, String newEmail) async {
    try {
      await _usersCollection.doc(uid).update({"email": newEmail});
      print("User Email Updated: $newEmail");
      return true;
    } catch (e) {
      print("Error Updating User Email: ${e.toString()}");
      return false;
    }
  }

  // Delete user from Firestore
  Future<bool> deleteUser(String uid) async {
    try {
      await _usersCollection.doc(uid).delete();
      print("User Deleted: $uid");
      return true;
    } catch (e) {
      print("Error Deleting User: ${e.toString()}");
      return false;
    }
  }
}