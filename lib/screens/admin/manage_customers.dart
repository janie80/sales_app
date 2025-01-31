import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/services/firestore_service.dart';
import 'package:sales_app/models/customer_model.dart';

class ManageCustomers extends StatelessWidget {
  const ManageCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    final TextEditingController nameController = TextEditingController();
    final TextEditingController contactController = TextEditingController();
    final TextEditingController voucherNumberController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Customers')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Customer Name')),
            TextField(controller: contactController, decoration: const InputDecoration(labelText: 'Contact Details')),
            TextField(controller: voucherNumberController, decoration: const InputDecoration(labelText: 'Voucher Number')),
            ElevatedButton(
              onPressed: () {
                final customer = CustomerModel(
                  id: DateTime.now().toString(),
                  name: nameController.text.trim(),
                  contact: contactController.text.trim(),
                  voucherNumber: voucherNumberController.text.trim(),
                );
                firestoreService.addCustomer(customer);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Customer added')));
              },
              child: const Text('Add Customer'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Customers').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final customers = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: customers.length,
                    itemBuilder: (context, index) {
                      final customer = customers[index].data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text(customer['name']),
                        subtitle: Text(customer['contact']),
                        trailing: Text(customer['voucherNumber']),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}