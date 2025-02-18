import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  final String id;
  final String name;
  final String contact;
  final String voucherNumber;

  CustomerModel({
    required this.id,
    required this.name,
    required this.contact,
    required this.voucherNumber,
  });

  // ✅ Convert CustomerModel to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'voucherNumber': voucherNumber,
    };
  }

  // ✅ Create CustomerModel from Firestore document
  factory CustomerModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CustomerModel(
      id: doc.id,
      name: data['name'] ?? '',
      contact: data['contact'] ?? '',
      voucherNumber: data['voucherNumber'] ?? '',
    );
  }
}
