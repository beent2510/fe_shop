import 'package:flutter/material.dart';

class CategoriesTab extends StatelessWidget {
  CategoriesTab({super.key});

  final List<String> categories = [
    'Hoa Tươi',
    'Hoa Lụa',
    'Cây Xanh',
    'Cây Nhân Tạo',
    'Bình Lọ Gốm',
    'Bình Lọ Thủy Tinh',
  ];

  final Map<String, List<Map<String, String>>> categoryProducts = {
    'Hoa Tươi': [
      {'name': 'Lan tường', 'price': '200,000đ', 'image': 'assets/lan_tuong.png'},
      {'name': 'Ly kép', 'price': '19,000đ', 'image': 'assets/ly_kep.png'},
    ],
    'Hoa Lụa': [
      {'name': 'Hoa lụa đỏ', 'price': '150,000đ', 'image': 'assets/hoa_lua_do.png'},
    ],
    'Cây Xanh': [
      {'name': 'Xương rồng mini', 'price': '90,000đ', 'image': 'assets/xuong_rong.png'},
    ],
    'Cây Nhân Tạo': [],
    'Bình Lọ Gốm': [],
    'Bình Lọ Thủy Tinh': [],
  };

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> selectedCategoryIndex = ValueNotifier(0);

    return SafeArea(
      child: Row(
        children: [
          // Danh sách danh mục
          Container(
            width: 100,
            color: const Color(0xFFF8F1F1),
            child: ValueListenableBuilder<int>(
              valueListenable: selectedCategoryIndex,
              builder: (context, selectedIndex, _) {
                return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final selected = index == selectedIndex;
                    return GestureDetector(
                      onTap: () => selectedCategoryIndex.value = index,
                      child: Container(
                        color: selected ? Colors.white : Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        child: Column(
                          children: [
                            const Icon(Icons.image, size: 30),
                            const SizedBox(height: 6),
                            Text(
                              categories[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Danh sách sản phẩm
          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: selectedCategoryIndex,
              builder: (context, selectedIndex, _) {
                String selectedCategory = categories[selectedIndex];
                List<Map<String, String>> products = categoryProducts[selectedCategory] ?? [];

                return Column(
                  children: [
                    // Thanh tìm kiếm
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Từ khoá sản phẩm...',
                                prefixIcon: const Icon(Icons.search),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.lock_outline, color: Colors.white),
                        ],
                      ),
                    ),

                    // Grid sản phẩm
                    Expanded(
                      child: products.isEmpty
                          ? const Center(child: Text('Không có sản phẩm'))
                          : GridView.count(
                              crossAxisCount: 2,
                              padding: const EdgeInsets.all(12),
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.75,
                              children: products.map((product) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Image.asset(product['image']!, fit: BoxFit.cover),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        child: Text(product['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Text(product['price']!, style: const TextStyle(color: Colors.red)),
                                      ),
                                      const Spacer(),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          icon: const Icon(Icons.add_circle_outline),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
