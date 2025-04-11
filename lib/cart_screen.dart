import 'package:flutter/material.dart';
import 'checkout_screen.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItem> _cartItems = [
    CartItem(image: 'assets/hoa1.jpg', title: 'Bó hoa hồng đỏ', price: 200000, quantity: 1),
    CartItem(image: 'assets/hoa2.jpg', title: 'Chậu lan trắng', price: 350000, quantity: 1),
  ];

  int get _totalPrice => _cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  void _increaseQty(int index) {
    setState(() {
      _cartItems[index].quantity++;
    });
  }

  void _decreaseQty(int index) {
    setState(() {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: _cartItems.isEmpty
          ? const Center(child: Text('Giỏ hàng của bạn đang trống'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _cartItems.length,
              itemBuilder: (context, index) => _buildCartItem(index),
            ),
      bottomNavigationBar: _cartItems.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              height: 140,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tổng cộng:', style: TextStyle(fontSize: 18)),
                      Text(
                        '${_totalPrice.toString()}đ',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CheckoutScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Tiến hành thanh toán', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildCartItem(int index) {
    final item = _cartItems[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(item.image, width: 70, height: 70, fit: BoxFit.cover),
        ),
        title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${item.price}đ x ${item.quantity} = ${item.totalPrice}đ',
              style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () => _decreaseQty(index),
                ),
                Text(item.quantity.toString()),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () => _increaseQty(index),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: () => _removeItem(index),
        ),
      ),
    );
  }
}

class CartItem {
  final String image;
  final String title;
  final int price;
  int quantity;

  CartItem({
    required this.image,
    required this.title,
    required this.price,
    this.quantity = 1,
  });

  int get totalPrice => price * quantity;
}
