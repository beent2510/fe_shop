import 'package:flutter/material.dart';
import 'product_management_screen.dart';
 // Để dùng class Product

class AddProductDialog extends StatefulWidget {
  final Product? existingProduct;

  const AddProductDialog({super.key, this.existingProduct});

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late String _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.existingProduct?.name ?? '');
    _priceController = TextEditingController(text: widget.existingProduct?.price.toString() ?? '');
    _selectedImage = widget.existingProduct?.image ?? 'assets/hoa1.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existingProduct == null ? 'Thêm sản phẩm mới' : 'Chỉnh sửa sản phẩm'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Tên sản phẩm'),
              validator: (value) => value == null || value.isEmpty ? 'Nhập tên sản phẩm' : null,
            ),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Giá sản phẩm'),
              keyboardType: TextInputType.number,
              validator: (value) => value == null || int.tryParse(value) == null ? 'Nhập giá hợp lệ' : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedImage,
              items: [
                'assets/hoa1.jpg',
                'assets/hoa2.jpg',
                'assets/hoa3.jpg',
              ].map((img) => DropdownMenuItem(value: img, child: Text(img))).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedImage = value;
                  });
                }
              },
              decoration: const InputDecoration(labelText: 'Chọn ảnh'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Hủy'),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: Text(widget.existingProduct == null ? 'Thêm' : 'Lưu'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final product = Product(
                image: _selectedImage,
                name: _nameController.text,
                price: int.parse(_priceController.text),
              );
              Navigator.pop(context, product);
            }
          },
        ),
      ],
    );
  }
}
