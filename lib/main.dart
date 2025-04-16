import 'package:flutter/material.dart';
// import 'home_screen.dart';
import 'admin_home.dart'; // Import admin

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AdminHomeScreen(), // Chạy trang admin
    );
  }
}
