import 'package:flutter/material.dart';

class AdminStaffTab extends StatefulWidget {
  const AdminStaffTab({super.key});

  @override
  State<AdminStaffTab> createState() => _AdminStaffTabState();
}

class _AdminStaffTabState extends State<AdminStaffTab> {
  List<Map<String, String>> staffList = [
    {
      'id': '1',
      'name': 'Ngừ iu tùng',
      'role': 'Quản lý',
      'email': 'nguyenvana@example.com',
      'avatarUrl': 'https://scontent.fsgn5-5.fna.fbcdn.net/v/t39.30808-6/485107968_1202209718188884_1056971212448037891_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeFsjoiNw5rsNrYNdrHX8HFxR1RZlezRyTZHVFmV7NHJNrbrbb_yJsCfP7LNiL2-MAkze5rcNWUOPL7opoCJC7Iq&_nc_ohc=7IA7LjgT2jQQ7kNvwFpg-Cn&_nc_oc=Adk46vdjl9xjc18k6qN4pNJyDQOiAB6a_7NUqvs7Km1HXIB02OeAtXUmw6H18GPFPuc&_nc_zt=23&_nc_ht=scontent.fsgn5-5.fna&_nc_gid=yQZwNoUiaVkhfGmzTxMTDg&oh=00_AfFjpuC-njyviL5BvgFPjUfD_VOtrTB9OsZARs-Otaml2w&oe=68054B3E'
    },
    {
      'id': '2',
      'name': 'Ngừ iu 2',
      'role': 'Nhân viên bán hàng',
      'email': 'tranthib@example.com',
      'avatarUrl': 'https://scontent.fsgn5-3.fna.fbcdn.net/v/t39.30808-6/472454240_122209576340031320_9064999945424639731_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeE_BlYA0qjnawfzBQ179xY8QrG46uZN01hCsbjq5k3TWPrBf83ZYPOmvfc-RtIARxuIPzKkAVzkYZ1N7gfKys_F&_nc_ohc=J4LoFo-D1qEQ7kNvwE0QYZ1&_nc_oc=Adkh9we8DyYfKlLyrRUoVvnJkdCauV-UoVjDzOUY0lnB_0-iqA087XcjWSP1JaMXAmg&_nc_zt=23&_nc_ht=scontent.fsgn5-3.fna&_nc_gid=hqKxSZTvYV0GDbCFSxuXlA&oh=00_AfG4_ad_TewBNt7rWYcN9o88iWZGK1rJSMOTzYXUIStjmg&oe=680544A5'
    },
    {
      'id': '3',
      'name': 'Lê Minh C',
      'role': 'Nhân viên kho',
      'email': 'leminhc@example.com',
      'avatarUrl': 'https://scontent.fsgn5-5.fna.fbcdn.net/v/t39.30808-6/480757939_1135104738403527_5966780491911646139_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=a5f93a&_nc_eui2=AeH-ESMm6bp62VG2lT-vcSZrapjMjh0jLKFqmMyOHSMsoZoFGTHpvoogqeDykUP_QQndYlEV9wrpCdfxq8lJ4OA2&_nc_ohc=VeUZONuawEMQ7kNvwEGtbkb&_nc_oc=Adkk-Vu9jZUsSsKmmlZz9PYFYSbyq0Oivwr6ZvYhrhhb4Tr8dyRLA2g0wwtUuPaH7k8&_nc_zt=23&_nc_ht=scontent.fsgn5-5.fna&_nc_gid=Yj-XDbho9WXBVwGnOMMUog&oh=00_AfHznj8kDgRdvUJ3o9IA5W4TFw5A37ZmJej3HHC-BLEJkg&oe=6805448A'
    },
    {
      'id': '4',
      'name': 'Ngừ iu 3',
      'role': 'Quản lý',
      'email': 'hoangvand@example.com',
      'avatarUrl': 'https://scontent.fsgn5-5.fna.fbcdn.net/v/t39.30808-6/480757939_1135104738403527_5966780491911646139_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=a5f93a&_nc_eui2=AeH-ESMm6bp62VG2lT-vcSZrapjMjh0jLKFqmMyOHSMsoZoFGTHpvoogqeDykUP_QQndYlEV9wrpCdfxq8lJ4OA2&_nc_ohc=VeUZONuawEMQ7kNvwEGtbkb&_nc_oc=Adkk-Vu9jZUsSsKmmlZz9PYFYSbyq0Oivwr6ZvYhrhhb4Tr8dyRLA2g0wwtUuPaH7k8&_nc_zt=23&_nc_ht=scontent.fsgn5-5.fna&_nc_gid=Yj-XDbho9WXBVwGnOMMUog&oh=00_AfHznj8kDgRdvUJ3o9IA5W4TFw5A37ZmJej3HHC-BLEJkg&oe=6805448A'
    },
    {
      'id': '5',
      'name': 'Phan Thị E',
      'role': 'Nhân viên bán hàng',
      'email': 'phanthie@example.com',
      'avatarUrl': 'https://i.pravatar.cc/150?img=5'
    },
  ];

  void _showStaffDialog({Map<String, String>? staff}) {
    final nameController = TextEditingController(text: staff?['name'] ?? '');
    final roleController = TextEditingController(text: staff?['role'] ?? '');
    final emailController = TextEditingController(text: staff?['email'] ?? '');
    final avatarUrlController = TextEditingController(text: staff?['avatarUrl'] ?? '');

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(staff == null ? '➕ Thêm Nhân Viên Mới' : '✏️ Sửa Thông Tin Nhân Viên'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Tên nhân viên')),
                TextField(controller: roleController, decoration: const InputDecoration(labelText: 'Vị trí')),
                TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
                TextField(controller: avatarUrlController, decoration: const InputDecoration(labelText: 'Avatar URL')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (staff == null) {
                    staffList.add({
                      'id': (staffList.length + 1).toString(),
                      'name': nameController.text,
                      'role': roleController.text,
                      'email': emailController.text,
                      'avatarUrl': avatarUrlController.text,
                    });
                  } else {
                    staff['name'] = nameController.text;
                    staff['role'] = roleController.text;
                    staff['email'] = emailController.text;
                    staff['avatarUrl'] = avatarUrlController.text;
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  void _deleteStaff(String staffId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc chắn muốn xóa nhân viên này không?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
          TextButton(
            onPressed: () {
              setState(() {
                staffList.removeWhere((staff) => staff['id'] == staffId);
              });
              Navigator.pop(context);
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var groupedStaff = <String, List<Map<String, String>>>{};
    for (var staff in staffList) {
      groupedStaff.putIfAbsent(staff['role']!, () => []).add(staff);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('👥 Quản lý nhân viên'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: groupedStaff.entries.map((entry) {
          return ExpansionTile(
            title: Text(entry.key, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            children: entry.value.map((staff) {
              final name = staff['name'] ?? '';
              final avatarUrl = staff['avatarUrl'] ?? '';
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  leading: avatarUrl.isNotEmpty
                      ? CircleAvatar(backgroundImage: NetworkImage(avatarUrl))
                      : CircleAvatar(
                          backgroundColor: Colors.pink.shade100,
                          child: Text(
                            name.isNotEmpty ? name[0] : '?',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                  title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("📌 Vị trí: ${staff['role']}"),
                      Text("📧 Email: ${staff['email']}"),
                    ],
                  ),
                  trailing: Wrap(
                    spacing: 4,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showStaffDialog(staff: staff),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteStaff(staff['id']!),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showStaffDialog(),
        backgroundColor: Colors.pinkAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
