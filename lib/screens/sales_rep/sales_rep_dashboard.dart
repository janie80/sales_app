import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/services/auth_service.dart';
import 'package:sales_app/screens/sales_rep/sales_data_summary.dart';
import 'package:sales_app/screens/sales_rep/task_list.dart';
import 'package:sales_app/screens/sales_rep/performance_tracker.dart';
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
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SalesRepLoginScreen()));
          },
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, Sales Rep!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Buttons for different functionalities
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SalesDataSummary()));
              },
              child: const Text('View Sales Data Summary'),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PerformanceTracker()));
              },
              child: const Text('Check Performance Tracker'),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const TaskList()));
              },
              child: const Text('View Task List'),
            ),
            const SizedBox(height: 10),

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
