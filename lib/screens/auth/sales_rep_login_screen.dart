import 'package:flutter/material.dart';
import 'package:sales_app/services/auth_service.dart';
import 'package:sales_app/models/user_model.dart';
import 'package:sales_app/screens/sales_rep/sales_rep_dashboard.dart'; // Import the Sales Rep dashboard
import 'package:sales_app/screens/auth/sales_rep_signup_screen.dart'; // Import the Sales Rep signup screen

class SalesRepLoginScreen extends StatefulWidget {
  const SalesRepLoginScreen({super.key});

  @override
  _SalesRepLoginScreenState createState() => _SalesRepLoginScreenState();
}

class _SalesRepLoginScreenState extends State<SalesRepLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _obscureText = true; // Toggle password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sales Rep Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
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
                  print('Sales Rep signed in: ${user.email}');
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
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SalesRepSignUpScreen()), // Navigate to Signup Screen
                );
              },
              child: const Text("Don't have an account? Sign up"),
            ),
            TextButton(
              onPressed: () async {
                final email = _emailController.text.trim();
                if (email.isNotEmpty) {
                  await _authService.resetPassword(email);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password reset email sent')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter your email')),
                  );
                }
              },
              child: const Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }
}
