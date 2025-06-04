import 'package:appnghenhac/ui/home/home.dart'; // Import màn hình trang chủ (Home)
import 'package:flutter/material.dart'; // Import thư viện giao diện Flutter
import 'package:firebase_auth/firebase_auth.dart'; // Import thư viện xác thực Firebase
import 'package:appnghenhac/ui/home/home.dart'; // Lặp lại import, chỉ cần 1 dòng này (dòng trên), nhưng không sửa code theo yêu cầu

// Định nghĩa màn hình đăng nhập dạng StatefulWidget vì có trạng thái thay đổi (loading, lỗi)
class NewLoginScreen extends StatefulWidget {
  const NewLoginScreen({super.key}); // Constructor mặc định

  @override
  State<NewLoginScreen> createState() => _NewLoginScreenState(); // Tạo state cho widget
}

// State của màn hình đăng nhập
class _NewLoginScreenState extends State<NewLoginScreen> {
  final TextEditingController emailController = TextEditingController(); // Controller lấy giá trị trường nhập email
  final TextEditingController passwordController = TextEditingController(); // Controller lấy giá trị trường nhập mật khẩu
  bool isLoading = false; // Biến trạng thái loading khi đăng nhập
  String errorMessage = ''; // Biến lưu thông báo lỗi

  // Hàm đăng nhập bằng email
  Future<void> loginWithEmail() async {
    final email = emailController.text.trim(); // Lấy email, loại bỏ khoảng trắng đầu/cuối
    final password = passwordController.text; // Lấy mật khẩu

    if (email.isEmpty || password.isEmpty) { // Kiểm tra email và mật khẩu đã nhập chưa
      setState(() => errorMessage = 'Vui lòng nhập đầy đủ thông tin'); // Nếu thiếu, báo lỗi
      return;
    }
    setState(() { isLoading = true; errorMessage = ''; }); // Bắt đầu loading, xoá lỗi cũ

    try {
      // Gọi Firebase để đăng nhập với email và mật khẩu
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (mounted) { // Kiểm tra widget còn tồn tại trên cây widget không
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Posali()), // Đăng nhập thành công, chuyển sang màn hình chính (Posali)
        );
      }
    } on FirebaseAuthException catch (e) { // Nếu có lỗi xác thực Firebase
      setState(() {
        errorMessage = e.message ?? 'Đăng nhập thất bại'; // Hiển thị lỗi
      });
    } finally {
      setState(() { isLoading = false; }); // Dừng loading dù thành công hay thất bại
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Màu nền đen
      appBar: AppBar(
        title: const Text("Đăng nhập"), // Tiêu đề AppBar
        backgroundColor: Colors.black, // AppBar nền đen
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0), // Padding toàn bộ nội dung
        child: Column(
          children: [
            // Trường nhập email
            TextField(
              controller: emailController, // Gắn controller cho email
              style: const TextStyle(color: Colors.white), // Chữ trắng
              decoration: const InputDecoration(
                labelText: 'Email', // Nhãn
                labelStyle: TextStyle(color: Colors.white), // Màu nhãn
                border: OutlineInputBorder(), // Viền
                filled: true, // Nền có màu
                fillColor: Colors.white10, // Nền trắng mờ
              ),
            ),
            const SizedBox(height: 16), // Khoảng cách
            // Trường nhập mật khẩu
            TextField(
              controller: passwordController, // Gắn controller cho mật khẩu
              obscureText: true, // Ẩn ký tự nhập vào
              style: const TextStyle(color: Colors.white), // Chữ trắng
              decoration: const InputDecoration(
                labelText: 'Mật khẩu', // Nhãn
                labelStyle: TextStyle(color: Colors.white), // Màu nhãn
                border: OutlineInputBorder(), // Viền
                filled: true, // Nền có màu
                fillColor: Colors.white10, // Nền trắng mờ
              ),
            ),
            const SizedBox(height: 24), // Khoảng cách
            // Hiển thị thông báo lỗi nếu có
            if (errorMessage.isNotEmpty)
              Text(errorMessage, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 8), // Khoảng cách
            // Nút đăng nhập
            SizedBox(
              width: double.infinity, // Chiều rộng tối đa
              child: ElevatedButton(
                onPressed: isLoading ? null : loginWithEmail, // Nếu đang loading thì disable nút, còn không thì gọi hàm đăng nhập
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Màu nền nút
                  padding: const EdgeInsets.symmetric(vertical: 18), // Padding dọc
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white) // Nếu đang loading thì hiện vòng quay
                    : const Text("Đăng nhập"), // Nếu không thì hiện chữ "Đăng nhập"
              ),
            ),
          ],
        ),
      ),
    );
  }
}