import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_app/services/firestore_service.dart';
import 'package:sales_app/models/order_model.dart';

class ManageOrders extends StatelessWidget {
  const ManageOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    final TextEditingController quantityController = TextEditingController();
    String? selectedCustomerId;
    String? selectedProductId;

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Orders')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown for Customers
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Customers').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                final customers = snapshot.data!.docs;
                return DropdownButton<String>(
                  value: selectedCustomerId,
                  hint: const Text('Select Customer'),
                  items: customers.map((customer) {
                    final data = customer.data() as Map<String, dynamic>;
                    return DropdownMenuItem<String>(
                      value: customer.id,
                      child: Text(data['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedCustomerId = value;
                  },
                );
              },
            ),

            // Dropdown for Products
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Products').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                final products = snapshot.data!.docs;
                return DropdownButton<String>(
                  value: selectedProductId,
                  hint: const Text('Select Product'),
                  items: products.map((product) {
                    final data = product.data() as Map<String, dynamic>;
                    return DropdownMenuItem<String>(
                      value: product.id,
                      child: Text(data['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedProductId = value;
                  },
                );
              },
            ),

            // Quantity Input
            TextField(controller: quantityController, decoration: const InputDecoration(labelText: 'Quantity'), keyboardType: TextInputType.number),

            // Add Order Button
            ElevatedButton(
              onPressed: () {
                if (selectedCustomerId == null || selectedProductId == null || quantityController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
                  return;
                }

                final order = OrderModel(
                  id: DateTime.now().toString(),
                  customerId: selectedCustomerId!,
                  productId: selectedProductId!,
                  quantity: int.parse(quantityController.text.trim()),
                );
                firestoreService.addOrder(order);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order added')));
              },
              child: const Text('Add Order'),
            ),

            // List of Orders
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final orders = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index].data() as Map<String, dynamic>;
                      return ListTile(
                        title: FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance.collection('Customers').doc(order['customerId']).get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final customer = snapshot.data!.data() as Map<String, dynamic>;
                              return Text('Customer: ${customer['name']}');
                            }
                            return const Text('Loading...');
                          },
                        ),
                        subtitle: FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance.collection('Products').doc(order['productId']).get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final product = snapshot.data!.data() as Map<String, dynamic>;
                              return Text('Product: ${product['name']}, Quantity: ${order['quantity']}');
                            }
                            return const Text('Loading...');
                          },
                        ),
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