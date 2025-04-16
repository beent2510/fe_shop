import 'package:flutter/material.dart';
import 'order.dart';

class AdminOrderTab extends StatefulWidget {
  const AdminOrderTab({super.key});

  @override
  State<AdminOrderTab> createState() => _AdminOrderTabState();
}

class _AdminOrderTabState extends State<AdminOrderTab> {
  List<Order> orders = [
    Order(
      id: "1",
      customerName: "Nguyễn Văn A",
      products: [
        {'name': 'Bó hoa hồng đỏ', 'price': '500.000đ'},
        {'name': 'Lẵng hoa lan trắng', 'price': '700.000đ'},
      ],
      totalPrice: 1200000,
      status: 'Đang xử lý',
    ),
    Order(
      id: "2",
      customerName: "Trần Thị B",
      products: [
        {'name': 'Giỏ hoa cúc vàng', 'price': '350.000đ'},
      ],
      totalPrice: 350000,
      status: 'Đang giao',
    ),
  ];

  void _updateOrderStatus(String orderId, String newStatus) {
    setState(() {
      orders.firstWhere((order) => order.id == orderId).status = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý đơn hàng"),
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 8,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                title: Text(
                  order.customerName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...order.products.map((product) {
                      return Text(
                        "${product['name']} - ${product['price']}",
                        style: const TextStyle(color: Colors.grey),
                      );
                    }),
                    const SizedBox(height: 8),
                    Text(
                      "Tổng giá: ${order.totalPrice}đ",
                      style: TextStyle(fontSize: 16, color: Colors.redAccent),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Trạng thái: ${order.status}",
                      style: TextStyle(color: _getStatusColor(order.status), fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward, color: Colors.redAccent),
                  onPressed: () {
                    _showOrderDetails(context, order);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showOrderDetails(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Chi tiết đơn hàng ${order.id}"),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...order.products.map((product) {
                  return Text("${product['name']} - ${product['price']}");
                }),
                const SizedBox(height: 8),
                Text("Tổng giá: ${order.totalPrice}đ", style: TextStyle(fontSize: 16, color: Colors.redAccent)),
                const SizedBox(height: 8),
                Text("Trạng thái hiện tại: ${order.status}"),
                const SizedBox(height: 16),
                DropdownButton<String>(
                  value: order.status,
                  onChanged: (newStatus) {
                    if (newStatus != null) {
                      _updateOrderStatus(order.id, newStatus);
                      Navigator.pop(context);
                    }
                  },
                  items: ['Đang xử lý', 'Đang giao', 'Hoàn thành'].map((status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Đang giao':
        return Colors.blue;
      case 'Hoàn thành':
        return Colors.green;
      default:
        return Colors.orange;
    }
  }
}
