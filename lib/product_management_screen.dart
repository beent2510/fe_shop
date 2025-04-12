import 'package:flutter/material.dart';
import 'AddProductDialog.dart';

class ProductManagementScreen extends StatefulWidget {
  const ProductManagementScreen({super.key});

  @override
  State<ProductManagementScreen> createState() => _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  final List<Product> _products = [
    Product(image: 'assets/hoa1.jpg', name: 'Hoa Hồng Đỏ', price: 200000),
    Product(image: 'assets/hoa2.jpg', name: 'Chậu Lan Trắng', price: 350000),
  ];

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý sản phẩm'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(product.image, width: 60, height: 60, fit: BoxFit.cover),
              ),
              title: Text(product.name),
              subtitle: Text('${product.price}đ'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blueAccent),
                    onPressed: () async {
                      final editedProduct = await showDialog<Product>(
                        context: context,
                        builder: (context) => AddProductDialog(
                          existingProduct: _products[index],
                        ),
                      );
                      if (editedProduct != null) {
                        setState(() {
                          _products[index] = editedProduct;
                        });
                      }
                    },

                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => _deleteProduct(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
       onPressed: () async {
  final newProduct = await showDialog<Product>(
    context: context,
    builder: (context) => const AddProductDialog(),
  );
  if (newProduct != null) {
    setState(() {
      _products.add(newProduct);
    });
  }
},

        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Product {
  final String image;
  final String name;
  final int price;

  Product({
    required this.image,
    required this.name,
    required this.price,
  });
}
