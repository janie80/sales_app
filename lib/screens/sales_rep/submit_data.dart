import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_app/services/firestore_service.dart';
import 'package:sales_app/models/sales_data_model.dart';

class SubmitData extends StatelessWidget {
  const SubmitData({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    final TextEditingController customerNameController = TextEditingController();
    final TextEditingController contactController = TextEditingController();
    final TextEditingController voucherNumberController = TextEditingController();
    final TextEditingController notesController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Submit Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: customerNameController,
              decoration: const InputDecoration(labelText: 'Customer Name'),
            ),
            TextField(
              controller: contactController,
              decoration: const InputDecoration(labelText: 'Contact Details'),
            ),
            TextField(
              controller: voucherNumberController,
              decoration: const InputDecoration(labelText: 'Voucher Number'),
            ),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(labelText: 'Notes'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (customerNameController.text.isEmpty ||
                    contactController.text.isEmpty ||
                    voucherNumberController.text.isEmpty ||
                    notesController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields')),
                  );
                  return;
                }

                final salesData = SalesDataModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
                  salesRepId: 'sales_rep_id', // Replace with actual Sales Rep ID
                  customerName: customerNameController.text.trim(),
                  contact: contactController.text.trim(),
                  voucherNumber: voucherNumberController.text.trim(),
                  notes: notesController.text.trim(),
                  timestamp: Timestamp.now(), // Use Firestore Timestamp
                );

                firestoreService.addSalesData(salesData);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data submitted successfully')),
                );

                // Clear input fields after submission
                customerNameController.clear();
                contactController.clear();
                voucherNumberController.clear();
                notesController.clear();
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
