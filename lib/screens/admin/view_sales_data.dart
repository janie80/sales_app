import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewSalesData extends StatelessWidget {
  const ViewSalesData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Sales Data')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('SalesData').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final salesData = snapshot.data!.docs;
          return ListView.builder(
            itemCount: salesData.length,
            itemBuilder: (context, index) {
              final data = salesData[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['customerName']),
                subtitle: Text(data['contact']),
                trailing: Text(data['voucherNumber']),
              );
            },
          );
        },
      ),
    );
  }
}