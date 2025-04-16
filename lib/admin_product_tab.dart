import 'package:flutter/material.dart';
import 'add_product_screen.dart';

class AdminProductTab extends StatefulWidget {
  const AdminProductTab({super.key});

  @override
  State<AdminProductTab> createState() => _AdminProductTabState();
}

class _AdminProductTabState extends State<AdminProductTab> {
  int selectedMenuIndex = 1; // 0: Danh mục, 1: Sản phẩm, 2: Giảm giá
  int selectedCategoryIndex = 0;

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

  List<Map<String, String>> discounts = [
    {
      'code': 'SALE10',
      'description': 'Giảm 10% cho đơn từ 500k',
    },
    {
      'code': 'HOA20',
      'description': 'Giảm 20% cho hoa hồng',
    },
  ];

  void _addCategory() {
    final TextEditingController categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Thêm danh mục mới"),
        content: TextField(
          controller: categoryController,
          decoration: const InputDecoration(labelText: "Tên danh mục"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Hủy")),
          TextButton(
            onPressed: () {
              setState(() {
                final name = categoryController.text.trim();
                if (name.isNotEmpty && !categories.contains(name)) {
                  categories.add(name);
                  categorizedProducts[name] = [];
                }
              });
              Navigator.pop(context);
            },
            child: const Text("Thêm"),
          ),
        ],
      ),
    );
  }

  void _editCategory(int index) {
    final TextEditingController categoryController = TextEditingController(text: categories[index]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sửa tên danh mục"),
        content: TextField(
          controller: categoryController,
          decoration: const InputDecoration(labelText: "Tên mới"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Hủy")),
          TextButton(
            onPressed: () {
              setState(() {
                final newName = categoryController.text.trim();
                if (newName.isNotEmpty && !categories.contains(newName)) {
                  String oldName = categories[index];
                  categories[index] = newName;
                  categorizedProducts[newName] = categorizedProducts.remove(oldName)!;
                }
              });
              Navigator.pop(context);
            },
            child: const Text("Lưu"),
          ),
        ],
      ),
    );
  }

  void _deleteCategory(int index) {
    setState(() {
      String name = categories[index];
      categorizedProducts.remove(name);
      categories.removeAt(index);
      if (selectedCategoryIndex >= categories.length) {
        selectedCategoryIndex = 0;
      }
    });
  }

  void _addProduct(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddProductScreen(
          category: category,
          onProductAdded: (newProduct) {
            if (!mounted) return;
            setState(() {
              categorizedProducts[category]?.add(newProduct);
            });
          },
        ),
      ),
    );
  }

  void _deleteProduct(String category, int index) {
    setState(() {
      categorizedProducts[category]?.removeAt(index);
    });
  }

  void _editProduct(String category, int index) {
    // TODO: Mở giao diện sửa sản phẩm
  }

  void _addDiscount() {
    final TextEditingController codeController = TextEditingController();
    final TextEditingController descController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Thêm mã giảm giá"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: codeController,
              decoration: const InputDecoration(labelText: "Mã giảm"),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: "Mô tả"),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Hủy")),
          TextButton(
            onPressed: () {
              setState(() {
                discounts.add({
                  'code': codeController.text.trim(),
                  'description': descController.text.trim(),
                });
              });
              Navigator.pop(context);
            },
            child: const Text("Thêm"),
          ),
        ],
      ),
    );
  }

 void _editDiscount(int index) {
  final TextEditingController codeController = TextEditingController(text: discounts[index]['code']);
  final TextEditingController descController = TextEditingController(text: discounts[index]['description']);

  showDialog(
    context: context,  // Đảm bảo sử dụng context từ widget hiện tại
    builder: (context) => AlertDialog(
      title: const Text("Sửa mã giảm giá"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: codeController,
            decoration: const InputDecoration(labelText: "Mã giảm"),
          ),
          TextField(
            controller: descController,
            decoration: const InputDecoration(labelText: "Mô tả"),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Hủy")),
        TextButton(
          onPressed: () {
            setState(() {
              discounts[index] = {
                'code': codeController.text.trim(),
                'description': descController.text.trim(),
              };
            });
            Navigator.pop(context);  // Đóng dialog khi lưu
          },
          child: const Text("Lưu"),
        ),
      ],
    ),
  );
}


  void _deleteDiscount(int index) {
    setState(() {
      discounts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    String currentCategory =
        categories.isNotEmpty ? categories[selectedCategoryIndex] : '';
    final currentProducts = categorizedProducts[currentCategory] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý sản phẩm"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Row(
        children: [
          // MENU TRÁI
          Container(
            width: 180,
            color: Colors.grey[200],
            child: Column(
              children: [
                _buildMenuTile("Danh mục sản phẩm", 0),
                _buildMenuTile("Sản phẩm", 1),
                _buildMenuTile("Giảm giá", 2),
              ],
            ),
          ),

          // GIAO DIỆN CHÍNH
          Expanded(
            child: selectedMenuIndex == 0
                ? _buildCategoryManager()
                : selectedMenuIndex == 1
                    ? _buildProductManager(currentCategory, currentProducts)
                    : _buildDiscountManager(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile(String title, int index) {
    return ListTile(
      selected: selectedMenuIndex == index,
      selectedTileColor: Colors.white,
      title: Text(
        title,
        style: TextStyle(
          color: selectedMenuIndex == index ? Colors.green : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        setState(() {
          selectedMenuIndex = index;
        });
      },
    );
  }

  Widget _buildCategoryManager() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(categories[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _editCategory(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteCategory(index),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        ElevatedButton.icon(
          onPressed: _addCategory,
          icon: const Icon(Icons.add),
          label: const Text("Thêm danh mục"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildProductManager(String category, List<Map<String, String>> products) {
    return categories.isEmpty
        ? const Center(child: Text("Chưa có danh mục nào."))
        : Column(
            children: [
              Container(
                height: 70,
                color: Colors.grey[100],
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    bool isSelected = index == selectedCategoryIndex;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedCategoryIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.green : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.green,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
                      elevation: 6,
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
                                onPressed: () => _editProduct(category, index),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteProduct(category, index),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _addProduct(category),
                icon: const Icon(Icons.add),
                label: const Text("Thêm sản phẩm"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          );
  }

  Widget _buildDiscountManager() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: discounts.length,
            itemBuilder: (context, index) {
              final discount = discounts[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(discount['code'] ?? ''),
                  subtitle: Text(discount['description'] ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _editDiscount(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteDiscount(index),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        ElevatedButton.icon(
          onPressed: _addDiscount,
          icon: const Icon(Icons.add),
          label: const Text("Thêm mã giảm giá"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
