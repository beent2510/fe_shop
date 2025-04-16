import 'package:flutter/material.dart';
import 'add_product_screen.dart';


class AdminProductTab extends StatefulWidget {
  const AdminProductTab({super.key});

  @override
  State<AdminProductTab> createState() => _AdminProductTabState();
}

class _AdminProductTabState extends State<AdminProductTab> {
  int selectedCategory = 0;

  final List<String> categories = [
    'Hoa Hồng',
    'Hoa Lan',
    'Hoa Tulip',
    'Hoa Cúc',
  ];

  final Map<String, List<Map<String, String>>> categorizedProducts = {
    'Hoa Hồng': [
      {
        'name': 'Bó hoa hồng đỏ',
        'price': '500.000đ',
        'image': 'assets/images/hoa1.jpg',
      },
    ],
    'Hoa Lan': [
      {
        'name': 'Lẵng hoa lan trắng',
        'price': '700.000đ',
        'image': 'assets/images/hoa2.jpg',
      },
    ],
    'Hoa Tulip': [
      {
        'name': 'Bó tulip hồng',
        'price': '450.000đ',
        'image': 'assets/images/hoa3.jpg',
      },
    ],
    'Hoa Cúc': [
      {
        'name': 'Giỏ hoa cúc vàng',
        'price': '350.000đ',
        'image': 'assets/images/hoa4.jpg',
      },
    ],
  };

  void _editProduct(String category, int index) {
    // TODO: Mở giao diện sửa sản phẩm
  }

  void _deleteProduct(String category, int index) {
    setState(() {
      categorizedProducts[category]?.removeAt(index);
    });
  }

  void _addProduct(String category) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => AddProductScreen(
        category: category,
        onProductAdded: (newProduct) {
          setState(() {
            categorizedProducts[category]?.add(newProduct);
          });
        },
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    final currentCategory = categories[selectedCategory];
    final products = categorizedProducts[currentCategory] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý sản phẩm"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Row(
        children: [
          // DANH MỤC
          Container(
            width: 100,
            color: Colors.grey[200],
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                bool isSelected = index == selectedCategory;
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedCategory = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    color: isSelected ? Colors.white : Colors.grey[200],
                    child: Center(
                      child: Text(
                        categories[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.red : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // DANH SÁCH SẢN PHẨM
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.asset(
                            product['image']!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(product['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(product['price']!, style: const TextStyle(color: Colors.red)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _editProduct(currentCategory, index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteProduct(currentCategory, index),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addProduct(currentCategory),
        backgroundColor: Colors.green,
        tooltip: "Thêm sản phẩm mới",
        child: const Icon(Icons.add),
      ),
    );
  }
}
