import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/services/auth_service.dart';
import 'package:sales_app/screens/sales_rep/sales_rep_dashboard.dart';
import 'package:sales_app/screens/auth/sales_rep_signup_screen.dart';
import 'package:get/get.dart'; // Make sure you have GetX package in your dependencies

class SalesRepLoginScreen extends StatefulWidget {
  const SalesRepLoginScreen({super.key});

  @override
  _SalesRepLoginScreenState createState() => _SalesRepLoginScreenState();
}

class _SalesRepLoginScreenState extends State<SalesRepLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sales Rep Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              obscureText: _obscureText,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text.trim();
                final password = _passwordController.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter both email and password')),
                  );
                  return;
                }

                final user = await _authService.signInSalesRep(email, password);
                if (user != null) {
                  if (kDebugMode) {
                    print('Sales Rep signed in: ${user.email}');
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SalesRepDashboard()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sign-in failed. Please check your credentials.')),
                  );
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SalesRepSignUpScreen()),
                );
              },
              child: const Text('Sign Up'),
            ),
            TextButton(
              onPressed: () async {
                final email = _emailController.text.trim();
                if (email.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter your email to reset your password')),
                  );
                  return;
                }

                await resetPassword(email);
              },
              child: const Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    try {
      await _authService.sendPasswordResetEmail(email: email);
      Get.snackbar('Success', 'Password reset email sent to $email');
    } catch (e) {
      print('Error during password reset: $e');
      Get.snackbar('Error', 'Error during password reset: $e');
    }
  }
}

extension on AuthService {
  sendPasswordResetEmail({required String email}) {}
}
