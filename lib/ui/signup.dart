import 'package:appnghenhac/ui/email_signup_screen.dart'; // Import màn hình đăng ký bằng email
import 'package:appnghenhac/ui/login.dart'; // Import màn hình đăng nhập
import 'package:flutter/material.dart'; // Import thư viện giao diện Flutter

// Widget màn hình đăng ký chính
class posaliSignUpScreen extends StatelessWidget {
  const posaliSignUpScreen({super.key}); // Constructor mặc định

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Màu nền toàn màn hình
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0, // Loại bỏ bóng đổ
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 28), // Nút back
          onPressed: () {
            Navigator.pop(context); // Quay lại màn hình trước
          },
        ),
      ),
      body: SafeArea(
        // Đảm bảo nội dung không bị che khuất bởi các phần như tai thỏ, thanh trạng thái
        child: Column(
          children: [
            const SizedBox(height: 32), // Khoảng trống phía trên
            // Logo ứng dụng ở giữa
            Center(
              child: Image.asset(
                'assets/ITunes_12.2_logo.png', // Đường dẫn logo (thay bằng logo của bạn)
                width: 80,
                height: 80,
              ),
            ),
            const SizedBox(height: 40), // Khoảng trống dưới logo
            // Tiêu đề đăng ký
            const Text(
              'Đăng ký để bắt đầu nghe',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 36),
            // Các nút đăng ký
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // Nút đăng ký bằng email
                  _SignUpButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmailSignUpScreen(), // Chuyển sang màn hình đăng ký bằng email
                        ),
                      );
                    },
                    color: Colors.blueAccent,
                    textColor: Colors.black,
                    icon: Icons.email_outlined,
                    text: "Tiếp tục bằng email",
                    border: BorderSide.none,
                  ),
                  const SizedBox(height: 16),
                  // Nút đăng ký bằng số điện thoại
                  _SignUpButton(
                    onPressed: () {},
                    color: Colors.transparent,
                    textColor: Colors.white,
                    icon: Icons.phone_iphone,
                    text: "Tiếp tục bằng số điện thoại",
                    border: const BorderSide(color: Colors.white54, width: 2),
                  ),
                  const SizedBox(height: 16),
                  // Nút đăng ký bằng Google
                  _SignUpButton(
                    onPressed: () {},
                    color: Colors.transparent,
                    textColor: Colors.white,
                    iconAsset: "assets/logogoogle.png", // Icon Google
                    text: "Tiếp tục bằng Google",
                    border: const BorderSide(color: Colors.white54, width: 2),
                  ),
                  const SizedBox(height: 16),
                  // Nút đăng ký bằng Apple
                  _SignUpButton(
                    onPressed: () {},
                    color: Colors.transparent,
                    textColor: Colors.white,
                    iconAsset: "assets/logoapple.png", // Icon Apple
                    text: "Tiếp tục bằng Apple",
                    border: const BorderSide(color: Colors.white54, width: 2),
                  ),
                  const SizedBox(height: 32),
                  // Phần chuyển sang đăng nhập nếu đã có tài khoản
                  Column(
                    children: [
                      const Text(
                        "Bạn đã có tài khoản?",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const posaliLoginScreen(), // Chuyển sang màn hình đăng nhập
                            ),
                          );
                        },
                        child: const Text(
                          "Đăng nhập",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(), // Đẩy phần dưới xuống dưới cùng
            // Thanh ngang nhỏ ở cuối màn hình (trang trí)
            Container(
              width: 120,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget nút đăng ký tuỳ biến, dùng cho tất cả lựa chọn đăng ký
class _SignUpButton extends StatelessWidget {
  final VoidCallback? onPressed; // Hàm xử lý khi bấm nút
  final Color color; // Màu nền nút
  final Color textColor; // Màu chữ/icon
  final IconData? icon; // Icon sử dụng trực tiếp từ Flutter
  final String? iconAsset; // Icon từ file ảnh (Google, Apple)
  final String text; // Nội dung nút
  final BorderSide border; // Viền nút

  const _SignUpButton({
    super.key,
    this.onPressed,
    required this.color,
    required this.textColor,
    this.icon,
    this.iconAsset,
    required this.text,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed, // Xử lý khi bấm nút
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0, // Không đổ bóng
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32), // Bo góc nút
            side: border, // Viền nút
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Hiển thị icon nếu có
            if (icon != null)
              Icon(icon, color: textColor, size: 24)
            else if (iconAsset != null)
              Image.asset(iconAsset!, width: 24, height: 24),
            const SizedBox(width: 18),
            // Nội dung nút
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}