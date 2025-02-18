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
            // Input Fields for Adding Products
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Product Name')),
            TextField(controller: priceController, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
            TextField(controller: stockController, decoration: const InputDecoration(labelText: 'Stock'), keyboardType: TextInputType.number),

            const SizedBox(height: 10),

            // Button to Add Product
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    priceController.text.isNotEmpty &&
                    stockController.text.isNotEmpty) {
                  final product = ProductModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: nameController.text.trim(),
                    price: double.parse(priceController.text.trim()),
                    stock: int.parse(stockController.text.trim()),
                  );

                  firestoreService.addProduct(product);

                  // Clear text fields after adding product
                  nameController.clear();
                  priceController.clear();
                  stockController.clear();

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product added')));
                }
              },
              child: const Text('Add Product'),
            ),

            const SizedBox(height: 20),

            // Display Products in a List
            Expanded(
              child: StreamBuilder<List<ProductModel>>(
                stream: firestoreService.getProducts(), // Listening for real-time updates
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No products available.'));
                  }

                  final products = snapshot.data!;

                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ListTile(
                        leading: const Icon(Icons.shopping_bag),
                        title: Text(product.name),
                        subtitle: Text('Price: \$${product.price} | Stock: ${product.stock}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            firestoreService.deleteProduct(product.id);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product deleted')));
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
