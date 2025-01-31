import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Admin credentials
  final String adminEmail = dotenv.env['ADMIN_EMAIL'] ?? 'admin@gmail.com';
  final String adminPassword = dotenv.env['ADMIN_PASSWORD'] ?? 'admin1234';

  // Sign in for Admin
  Future<UserModel?> signInAdmin(String email, String password) async {
    try {
      // Validate admin credentials
      if (email == adminEmail && password == adminPassword) {
        // Sign in with Firebase
        UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
        User? user = result.user;
        if (user != null) {
          return UserModel(uid: user.uid, email: user.email!);
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
  Future<UserModel?> signInSalesRep(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user != null) {
        // Fetch user data from Firestore
        DocumentSnapshot doc = await _firestore.collection('Users').doc(user.uid).get();
        if (doc.exists) {
          return UserModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
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
  Future<UserModel?> signUpSalesRep(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user != null) {
        // Store user data in Firestore
        await _firestore.collection('Users').doc(user.uid).set({
          'email': email,
        });
        return UserModel(uid: user.uid, email: user.email!);
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
