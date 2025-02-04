import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login User
  Future<UserCredential?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        return userCredential;
      } else {
        return null;
      }
    } catch (e) {
      print('Login error: $e');
      Get.snackbar('Error', 'Login failed: ${e.toString()}');
      return null;
    }
  }

  // Register User
  Future<UserCredential?> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        return userCredential;
      } else {
        return null;
      }
    } catch (e) {
      print('Registration error: $e');
      Get.snackbar('Error', 'Registration failed: ${e.toString()}');
      return null;
    }
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Success', 'Password reset email sent to $email');
    } catch (e) {
      print('Password reset error: $e');
      Get.snackbar('Error', 'Failed to send password reset email: ${e.toString()}');
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.snackbar('Success', 'Signed out successfully');
    } catch (e) {
      print('Sign out error: $e');
      Get.snackbar('Error', 'Failed to sign out: ${e.toString()}');
    }
  }

  // Get Current User
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}