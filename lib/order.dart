class Order {
  final String id;
  final String customerName;
  final List<Map<String, String>> products;
  final double totalPrice;
  String status; // "Đang xử lý", "Đang giao", "Hoàn thành"

  Order({
    required this.id,
    required this.customerName,
    required this.products,
    required this.totalPrice,
    this.status = "Đang xử lý",
  });
}
