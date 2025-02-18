import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import '../models/customer_model.dart';
import '../models/order_model.dart';
import '../models/sales_data_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add Admin User
  Future<void> addAdminUser() async {
    try {
      await _firestore.collection('Users').doc('admin@gmail.com').set({
        'email': 'admin@gmail.com',
        'role': 'admin',
      });
      print('✅ Admin user added successfully');
    } catch (error) {
      print('❌ Failed to add admin: $error');
    }
  }

  // ✅ Add Product
  Future<void> addProduct(ProductModel product) async {
    await _firestore.collection('Products').doc(product.id).set(product.toJson());
  }

  // ✅ Get Products (Stream for Real-time Updates)
  Stream<List<ProductModel>> getProducts() {
    return _firestore.collection('Products').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList());
  }

  // ✅ Delete Product
  Future<void> deleteProduct(String id) async {
    await _firestore.collection('Products').doc(id).delete();
  }

  // ✅ Add Customer
  Future<void> addCustomer(CustomerModel customer) async {
    await _firestore.collection('Customers').doc(customer.id).set(customer.toJson());
  }

  // ✅ Add Order
  Future<void> addOrder(OrderModel order) async {
    await _firestore.collection('Orders').doc(order.id).set(order.toJson());
  }

  // ✅ Add Sales Data
  Future<void> addSalesData(SalesDataModel salesData) async {
    await _firestore.collection('SalesData').doc(salesData.id).set(salesData.toJson());
  }
}
