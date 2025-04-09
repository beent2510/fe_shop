import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildSearchBox(),
            const SizedBox(height: 16),
            const Text("Hoa hồng"),
            const Divider(),
            const Text("Xoá lịch sử tìm kiếm",
                style: TextStyle(color: Colors.blue)),
            const SizedBox(height: 24),
            const Text("Từ khoá hot",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildHotKeyword("Hoa hồng"),
            _buildHotKeyword("Cây xanh"),
            const SizedBox(height: 24),
            _buildBanner(),
            const SizedBox(height: 24),
            const Text("Sản phẩm đã xem",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text("Chưa có sản phẩm nào.",
                style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Từ khoá sản phẩm...",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: const Color(0xFFF6F2E7),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        suffixIcon: const Icon(Icons.qr_code_scanner_outlined),
      ),
    );
  }

  Widget _buildHotKeyword(String keyword) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.search, size: 18, color: Colors.grey),
          const SizedBox(width: 8),
          Text(keyword),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        "assets/images/banner.png", // Thay bằng ảnh của bạn
        fit: BoxFit.cover,
      ),
    );
  }
}
