import 'package:flutter/material.dart';
import 'product_detail_screen.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  int selectedCategory = 0;

  final List<String> categories = [
    'Hoa Hồng',
    'Hoa Lan',
    'Hoa Tulip',
    'Hoa Cúc',
  ];

  final List<Map<String, String>> products = [
    {
      'name': 'Bó hoa hồng đỏ',
      'price': '500.000đ',
      'image': 'assets/images/hoa1.jpg',
    },
    {
      'name': 'Lẵng hoa lan trắng',
      'price': '700.000đ',
      'image': 'assets/images/hoa2.jpg',
    },
    {
      'name': 'Bó tulip hồng',
      'price': '450.000đ',
      'image': 'assets/images/hoa3.jpg',
    },
    {
      'name': 'Giỏ hoa cúc vàng',
      'price': '350.000đ',
      'image': 'assets/images/hoa4.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // DANH MỤC BÊN TRÁI
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
                  color: isSelected ? Colors.white : Colors.grey[200],
                  padding: const EdgeInsets.symmetric(vertical: 20),
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

        // SẢN PHẨM BÊN PHẢI
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(8),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.7,
            children: products.map((product) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(
                        title: product['name']!,
                        price: product['price']!,
                        image: product['image']!,
                      ),
                    ),
                  );
                },
                child: Container(
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
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(product['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(product['price']!, style: const TextStyle(color: Colors.red)),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () {
                            // TODO: thêm vào giỏ hàng
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
