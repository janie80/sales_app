import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/services/firestore_service.dart';
import 'package:sales_app/models/product_model.dart';

class ManageProducts extends StatelessWidget {
  const ManageProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController stockController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Products')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Product Name')),
            TextField(controller: priceController, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
            TextField(controller: stockController, decoration: const InputDecoration(labelText: 'Stock'), keyboardType: TextInputType.number),
            ElevatedButton(
              onPressed: () {
                final product = ProductModel(
                  id: DateTime.now().toString(),
                  name: nameController.text.trim(),
                  price: double.parse(priceController.text.trim()),
                  stock: int.parse(stockController.text.trim()),
                );
                firestoreService.addProduct(product);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product added')));
              },
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}