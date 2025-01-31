class OrderModel {
  final String id;
  final String customerId;
  final String productId;
  final int quantity;

  OrderModel({required this.id, required this.customerId, required this.productId, required this.quantity});
}