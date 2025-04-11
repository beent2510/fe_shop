import 'package:flutter/material.dart';
import 'checkout_screen.dart';

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

class CartModel {
  static final List<CartItem> _cartItems = [];

  static List<CartItem> get items => _cartItems;

  static void addItem(CartItem newItem) {
    final index = _cartItems.indexWhere((item) => item.title == newItem.title);
    if (index != -1) {
      _cartItems[index].quantity += newItem.quantity;
    } else {
      _cartItems.add(newItem);
    }
  }

  static void removeItem(int index) {
    _cartItems.removeAt(index);
  }

  static void increaseQty(int index) {
    _cartItems[index].quantity++;
  }

  static void decreaseQty(int index) {
    if (_cartItems[index].quantity > 1) {
      _cartItems[index].quantity--;
    }
  }

  static int get totalPrice => _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartItems = CartModel.items;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Giỏ hàng của bạn đang trống'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: cartItems.length,
              itemBuilder: (context, index) => _buildCartItem(index),
            ),
      bottomNavigationBar: cartItems.isEmpty
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
                        '${CartModel.totalPrice}đ',
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
    final item = CartModel.items[index];
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
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      CartModel.decreaseQty(index);
                    });
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('${item.quantity}', style: const TextStyle(fontSize: 16)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      CartModel.increaseQty(index);
                    });
                  },
                  icon: const Icon(Icons.add_circle_outline),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      CartModel.removeItem(index);
                    });
                  },
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
