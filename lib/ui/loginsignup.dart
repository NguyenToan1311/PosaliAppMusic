import 'package:flutter/material.dart'; // Thư viện giao diện Flutter
import 'signup.dart'; // Import màn hình đăng ký (đã có)
import 'login.dart';  // Import màn hình đăng nhập (bạn vừa thêm)

class SpotifyIntroScreen extends StatelessWidget {
  const SpotifyIntroScreen({super.key}); // Constructor mặc định (StatelessWidget)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Đặt màu nền cho màn hình là đen
      body: SafeArea(
        // Đảm bảo nội dung không bị che khuất bởi notch, status bar, v.v.
        child: Column(
          children: [
            const SizedBox(height: 80), // Khoảng cách phía trên cho thoáng
            Center(
              child: Image.asset(
                'assets/ITunes_12.2_logo.png', // Hiển thị logo ứng dụng từ file assets
                width: 80,
                height: 80,
              ),
            ),
            const SizedBox(height: 40), // Khoảng cách giữa logo và tiêu đề
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0), // Padding ngang cho tiêu đề
              child: Column(
                children: const [
                  // Dòng tiêu đề lớn thứ nhất
                  Text(
                    'Hàng triệu bài hát.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 8), // Khoảng cách giữa hai dòng tiêu đề
                  // Dòng tiêu đề lớn thứ hai
                  Text(
                    'Miễn phí trên Posali.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(), // Đẩy phần dưới xuống cuối màn hình
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), // Padding ngang cho các nút
              child: Column(
                children: [
                  // Nút "Đăng ký miễn phí"
                  SizedBox(
                    width: double.infinity, // Nút chiếm toàn bộ chiều ngang
                    child: ElevatedButton(
                      onPressed: () {
                        // Khi bấm, chuyển sang màn hình đăng ký
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const posaliSignUpScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent, // Nút nền xanh dương
                        foregroundColor: Colors.black, // Màu chữ đen
                        padding: const EdgeInsets.symmetric(vertical: 18), // Padding dọc lớn cho nút
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32), // Bo góc nút
                        ),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        elevation: 0, // Không đổ bóng
                      ),
                      child: const Text('Đăng ký miễn phí'), // Nội dung nút
                    ),
                  ),
                  const SizedBox(height: 16), // Khoảng cách giữa hai nút
                  // Nút "Đăng nhập"
                  SizedBox(
                    width: double.infinity, // Nút chiếm toàn bộ chiều ngang
                    child: OutlinedButton(
                      onPressed: () {
                        // Khi bấm, chuyển sang màn hình đăng nhập
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const posaliLoginScreen(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white, // Màu chữ trắng
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32), // Bo góc nút
                        ),
                        side: const BorderSide(
                          color: Colors.white54, // Viền trắng mờ
                          width: 2,
                        ),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      child: const Text('Đăng nhập'), // Nội dung nút
                    ),
                  ),
                  const SizedBox(height: 32), // Khoảng cách phía dưới các nút
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}