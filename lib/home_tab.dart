import 'package:flutter/material.dart';
import 'cart_screen.dart';
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  // Hàm tính giá ưu đãi theo giờ
  String getDiscountedPrice(String originalPrice) {
    final now = DateTime.now();
    final hour = now.hour;

    // Chuyển '200.000đ' -> 200000
    final rawPrice = int.tryParse(originalPrice.replaceAll('.', '').replaceAll('đ', '')) ?? 0;

    double discount = 0.0;
    if (hour >= 6 && hour < 10) {
      discount = 0.2; // Giảm 20%
    } else if (hour >= 20 && hour < 22) {
      discount = 0.1; // Giảm 10%
    }

    final discountedPrice = rawPrice * (1 - discount);
    return "${discountedPrice.toInt().toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}đ";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.grey),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Tìm kiếm...',
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black87),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
  );
              // Xử lý khi nhấn giỏ hàng
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          // Banner
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('assets/banner.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 20),
          const Text(
            'Danh mục',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // Hàng 1
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryItem('assets/images/hoa1.jpg', 'Hoa hồng'),
                _buildCategoryItem('assets/hoa2.jpg', 'Hoa lan'),
                _buildCategoryItem('assets/hoa3.jpg', 'Hoa ly'),
                _buildCategoryItem('assets/hoa4.jpg', 'Hoa tulip'),
                _buildCategoryItem('assets/hoa5.jpg', 'Cẩm chướng'),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Hàng 2
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryItem('assets/hoa6.jpg', 'Hoa hướng dương'),
                _buildCategoryItem('assets/hoa7.jpg', 'Hoa cúc'),
                _buildCategoryItem('assets/hoa8.jpg', 'Hoa mẫu đơn'),
                _buildCategoryItem('assets/hoa9.jpg', 'Hoa sen'),
                _buildCategoryItem('assets/hoa10.jpg', 'Hoa baby'),
              ],
            ),
          ),

          const SizedBox(height: 20),
          const Text(
            'Ưu đãi theo giờ ⏰',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              _buildProductItem('assets/hoa1.jpg', 'Hoa hồng khuyến mãi', getDiscountedPrice('200.000đ')),
              _buildProductItem('assets/hoa2.jpg', 'Lan ưu đãi', getDiscountedPrice('350.000đ')),
            ],
          ),

          const SizedBox(height: 20),
          const Text(
            'Sản phẩm mới',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              _buildProductItem('assets/hoa1.jpg', 'Bó hoa hồng đỏ', '200.000đ'),
              _buildProductItem('assets/hoa2.jpg', 'Chậu lan trắng', '350.000đ'),
              _buildProductItem('assets/hoa3.jpg', 'Bó hoa ly vàng', '250.000đ'),
              _buildProductItem('assets/hoa4.jpg', 'Hoa tulip Hà Lan', '300.000đ'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String image, String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(image, width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildProductItem(String image, String title, String price) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(image, height: 120, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(price, style: const TextStyle(color: Colors.redAccent)),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart, size: 16),
              label: const Text('Thêm'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(35),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
