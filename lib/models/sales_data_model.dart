import 'package:cloud_firestore/cloud_firestore.dart';

class SalesDataModel {
  final String id;
  final String salesRepId;
  final String customerName;
  final String contact;
  final String voucherNumber;
  final String notes;
  final Timestamp timestamp; // Change to Firestore Timestamp

  SalesDataModel({
    required this.id,
    required this.salesRepId,
    required this.customerName,
    required this.contact,
    required this.voucherNumber,
    required this.notes,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'salesRepId': salesRepId,
      'customerName': customerName,
      'contact': contact,
      'voucherNumber': voucherNumber,
      'notes': notes,
      'timestamp': timestamp,
    };
  }

  factory SalesDataModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SalesDataModel(
      id: doc.id,
      salesRepId: data['salesRepId'] ?? '',
      customerName: data['customerName'] ?? '',
      contact: data['contact'] ?? '',
      voucherNumber: data['voucherNumber'] ?? '',
      notes: data['notes'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(), // Use Timestamp.now() as default
    );
  }
}
