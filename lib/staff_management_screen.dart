import 'package:flutter/material.dart';

class StaffManagementScreen extends StatefulWidget {
  const StaffManagementScreen({super.key});

  @override
  State<StaffManagementScreen> createState() => _StaffManagementScreenState();
}

class _StaffManagementScreenState extends State<StaffManagementScreen> {
  final List<Staff> _staffs = [
    Staff(name: 'Nguyễn Văn A', role: 'Nhân viên bán hàng'),
    Staff(name: 'Trần Thị B', role: 'Quản lý kho'),
  ];

  void _deleteStaff(int index) {
    setState(() {
      _staffs.removeAt(index);
    });
  }

  void _showAddStaffDialog() async {
    final newStaff = await showDialog<Staff>(
      context: context,
      builder: (context) => const AddStaffDialog(),
    );
    if (newStaff != null) {
      setState(() {
        _staffs.add(newStaff);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý nhân viên'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _staffs.length,
        itemBuilder: (context, index) {
          final staff = _staffs[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.person, size: 36, color: Colors.deepPurple),
              title: Text(staff.name),
              subtitle: Text(staff.role),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () => _deleteStaff(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddStaffDialog,
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Staff {
  final String name;
  final String role;

  Staff({required this.name, required this.role});
}

class AddStaffDialog extends StatefulWidget {
  const AddStaffDialog({super.key});

  @override
  State<AddStaffDialog> createState() => _AddStaffDialogState();
}

class _AddStaffDialogState extends State<AddStaffDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Thêm nhân viên mới'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Tên nhân viên'),
          ),
          TextField(
            controller: _roleController,
            decoration: const InputDecoration(labelText: 'Chức vụ'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () {
            final name = _nameController.text.trim();
            final role = _roleController.text.trim();
            if (name.isNotEmpty && role.isNotEmpty) {
              Navigator.pop(context, Staff(name: name, role: role));
            }
          },
          child: const Text('Thêm'),
        ),
      ],
    );
  }
}
