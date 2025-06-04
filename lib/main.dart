import 'package:flutter/cupertino.dart'; // Thư viện giao diện iOS
import 'package:flutter/material.dart';  // Thư viện Material Design
import 'package:appnghenhac/ui/home/home.dart'; // Màn hình trang chủ
import 'package:appnghenhac/ui/loginsignup.dart'; // Màn hình đăng nhập/đăng ký
import 'package:firebase_core/firebase_core.dart'; // Khởi tạo Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo Flutter đã khởi tạo trước khi chạy async
  await Firebase.initializeApp(); // Khởi tạo Firebase
  runApp(const Posali()); // Chạy ứng dụng với widget Posali
}

class Posali extends StatelessWidget { // Widget không có trạng thái
  const Posali({super.key}); // Constructor

  @override
  Widget build(BuildContext context) { // Hàm dựng giao diện
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Ẩn banner debug
      home: SpotifyIntroScreen(), // Màn hình đầu tiên
    );
  }
}