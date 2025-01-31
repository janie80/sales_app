class SalesDataModel {
  final String id;
  final String salesRepId;
  final String customerName;
  final String contact;
  final String voucherNumber;
  final String notes;
  final DateTime timestamp;

  SalesDataModel({
    required this.id,
    required this.salesRepId,
    required this.customerName,
    required this.contact,
    required this.voucherNumber,
    required this.notes,
    required this.timestamp,
  });
}