import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import '../models/customer_model.dart';
import '../models/order_model.dart';
import '../models/sales_data_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add product
  Future<void> addProduct(ProductModel product) async {
    await _firestore.collection('Products').doc(product.id).set({
      'name': product.name,
      'price': product.price,
      'stock': product.stock,
    });
  }

  // Add customer
  Future<void> addCustomer(CustomerModel customer) async {
    await _firestore.collection('Customers').doc(customer.id).set({
      'name': customer.name,
      'contact': customer.contact,
      'voucherNumber': customer.voucherNumber,
    });
  }

  // Add order
  Future<void> addOrder(OrderModel order) async {
    await _firestore.collection('Orders').doc(order.id).set({
      'customerId': order.customerId,
      'productId': order.productId,
      'quantity': order.quantity,
    });
  }

  // Add sales data
  Future<void> addSalesData(SalesDataModel salesData) async {
    await _firestore.collection('SalesData').doc(salesData.id).set({
      'salesRepId': salesData.salesRepId,
      'customerName': salesData.customerName,
      'contact': salesData.contact,
      'voucherNumber': salesData.voucherNumber,
      'notes': salesData.notes,
      'timestamp': salesData.timestamp,
    });
  }
}