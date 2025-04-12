import 'package:flutter/material.dart';

class OrderManagementScreen extends StatelessWidget {
  const OrderManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Order> orders = [
      Order(id: 'DH001', customer: 'Nguyễn Văn A', total: 450000, status: 'Đang xử lý'),
      Order(id: 'DH002', customer: 'Trần Thị B', total: 620000, status: 'Đã giao'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý đơn hàng'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(order.id),
                backgroundColor: Colors.pink.shade100,
              ),
              title: Text('Khách: ${order.customer}'),
              subtitle: Text('Tổng: ${order.total}đ\nTrạng thái: ${order.status}'),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // TODO: Hiển thị chi tiết hoặc cập nhật đơn hàng
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class Order {
  final String id;
  final String customer;
  final int total;
  final String status;

  Order({
    required this.id,
    required this.customer,
    required this.total,
    required this.status,
  });
}
