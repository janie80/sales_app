import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/services/auth_service.dart';
import 'package:sales_app/services/user_provider.dart';

import '../auth/sales_rep_login_screen.dart'; // Ensure this import is correct

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Email: ${userProvider.user?.email}'), // Display user email
            const SizedBox(height: 20), // Add some spacing
            ElevatedButton(
              onPressed: () async {
                await authService.signOut(); // Sign out the user
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SalesRepLoginScreen()), // Redirect to login screen
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}