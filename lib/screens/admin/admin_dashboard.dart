import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/screens/admin/view_sales_data.dart';
import '../../services/auth_service.dart';
import '../auth/admin_login_screen.dart';
import 'package:sales_app/screens/admin/manage_products.dart';
import 'package:sales_app/screens/admin/manage_customers.dart';
import 'package:sales_app/screens/admin/manage_orders.dart';


class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard'), actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            final authService = Provider.of<AuthService>(context, listen: false);
            await authService.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  const AdminLoginScreen()));
          },
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageProducts()));
              },
              child: const Text('Manage Products'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageCustomers()));
              },
              child: const Text('Manage Customers'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageOrders()));
              },
              child: const Text('Manage Orders'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewSalesData()));
              },
              child: const Text('View Sales Data'),
            ),
          ],
        ),
      ),
    );
  }
}