import 'package:flutter/material.dart';
import 'package:sales_app/services/auth_service.dart';
import 'package:sales_app/models/user_model.dart';
import 'package:sales_app/screens/admin/admin_dashboard.dart'; // Import the Admin dashboard

class AdminLoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text.trim();
                final password = _passwordController.text.trim();
                final user = await _authService.signInAdmin(email, password);
                if (user != null) {
                  print('Admin signed in: ${user.email}');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminDashboard()),
                  );
                } else {
                  print('Invalid admin credentials');
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
