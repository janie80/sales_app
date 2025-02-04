import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/user_details.dart';
import '../models/user_model.dart';
import '../services/user_storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserStorage _userStorage = UserStorage();

  // Admin credentials
  final String adminEmail = dotenv.env['ADMIN_EMAIL'] ?? 'admin@gmail.com';
  final String adminPassword = dotenv.env['ADMIN_PASSWORD'] ?? 'admin1234';

  // Sign in for Admin
  Future<PigeonUserDetails?> signInAdmin(String email, String password) async {
    try {
      // Validate admin credentials
      if (email == adminEmail && password == adminPassword) {
        // Sign in with Firebase
        UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
        User? user = result.user;
        if (user != null) {
          // Create PigeonUserDetails object with the passed values
          PigeonUserDetails pigeonUserDetails = PigeonUserDetails(
            uid: user.uid,
            email: user.email!,
            name: 'Admin Name', // Provide the admin's name here
          );
          return pigeonUserDetails;
        }
      } else {
        print('Invalid admin credentials');
      }
      return null;
    } catch (e) {
      print('Error during admin sign-in: $e');
      return null;
    }
  }

  // Sign in for Sales Rep
  Future<PigeonUserDetails?> signInSalesRep(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user != null) {
        // Fetch user data from Firestore using UserStorage
        UserModel? userModel = await _userStorage.getUser(user.uid);
        if (userModel != null) {
          return PigeonUserDetails(
            uid: userModel.uid,
            email: userModel.email,
            name: 'Sales Rep Name', // Provide the sales rep's name here
          );
        } else {
          print('User not found in Firestore');
          return null;
        }
      }
      return null;
    } catch (e) {
      print('Error during sign-in: $e');
      return null;
    }
  }

  // Sign up for Sales Rep
  Future<PigeonUserDetails?> signUpSalesRep(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user != null) {
        // Create UserModel object
        UserModel userModel = UserModel(uid: user.uid, email: user.email!);
        // Save user to Firestore using UserStorage
        await _userStorage.saveUser(userModel);
        return PigeonUserDetails(
          uid: user.uid,
          email: user.email!,
          name: 'Sales Rep Name', // Provide the sales rep's name here
        );
      }
      return null;
    } catch (e) {
      print('Error during sign-up: $e');
      return null;
    }
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print('Password reset email sent to $email');
    } catch (e) {
      print('Error during password reset: $e');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error during sign-out: $e');
      throw Exception('Sign-out failed');
    }
  }
}
