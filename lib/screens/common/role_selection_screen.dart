import 'package:flutter/material.dart';

import '../auth/admin_login_screen.dart';
import '../auth/sales_rep_signup_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  SalesRepSignUpScreen()),
                );
              },
              child: const Text('Sales Rep'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AdminLoginScreen()),
                );
              },
              child: const Text('Admin'),
            ),
          ],
        ),
      ),
    );
  }
}