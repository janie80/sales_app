import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String customerId;
  final String productId;
  final int quantity;
  final Timestamp timestamp; // Using Firestore Timestamp

  OrderModel({
    required this.id,
    required this.customerId,
    required this.productId,
    required this.quantity,
    required this.timestamp,
  });

  // Convert OrderModel to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'productId': productId,
      'quantity': quantity,
      'timestamp': timestamp,
    };
  }

  // Create OrderModel from Firestore document
  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      id: doc.id,
      customerId: data['customerId'] ?? '',
      productId: data['productId'] ?? '',
      quantity: data['quantity'] ?? 0,
      timestamp: data['timestamp'] ?? Timestamp.now(), // Default to current time if missing
    );
  }
}
