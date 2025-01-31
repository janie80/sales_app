import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/services/auth_service.dart';
import 'package:sales_app/screens/sales_rep/submit_data.dart';

import '../auth/sales_rep_login_screen.dart';

class SalesRepDashboard extends StatelessWidget {
  const SalesRepDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sales Rep Dashboard'), actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            final authService = Provider.of<AuthService>(context, listen: false);
            await authService.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SalesRepLoginScreen()));
          },
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SubmitData()));
              },
              child: const Text('Submit Data'),
            ),
          ],
        ),
      ),
    );
  }
}