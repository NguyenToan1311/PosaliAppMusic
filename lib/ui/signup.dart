import 'package:appnghenhac/ui/email_signup_screen.dart';
import 'package:appnghenhac/ui/login.dart';
import 'package:flutter/material.dart';

class posaliSignUpScreen extends StatelessWidget {
  const posaliSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 28),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            // Logo
            Center(
              child: Image.asset(
                'assets/ITunes_12.2_logo.png', // Thay logo của bạn tại đây
                width: 80,
                height: 80,
              ),
            ),
            const SizedBox(height: 40),
            // Title
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
            // Đăng ký bằng email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _SignUpButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmailSignUpScreen(),
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
                  _SignUpButton(
                    onPressed: () {},
                    color: Colors.transparent,
                    textColor: Colors.white,
                    icon: Icons.phone_iphone,
                    text: "Tiếp tục bằng số điện thoại",
                    border: const BorderSide(color: Colors.white54, width: 2),
                  ),
                  const SizedBox(height: 16),
                  _SignUpButton(
                    onPressed: () {},
                    color: Colors.transparent,
                    textColor: Colors.white,
                    iconAsset:
                        "assets/logogoogle.png", // Thay icon Google của bạn
                    text: "Tiếp tục bằng Google",
                    border: const BorderSide(color: Colors.white54, width: 2),
                  ),
                  const SizedBox(height: 16),
                  _SignUpButton(
                    onPressed: () {},
                    color: Colors.transparent,
                    textColor: Colors.white,
                    iconAsset:
                        "assets/logoapple.png", // Thay icon Apple của bạn
                    text: "Tiếp tục bằng Apple",
                    border: const BorderSide(color: Colors.white54, width: 2),
                  ),
                  const SizedBox(height: 32),
                  // Đăng nhập
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
                              builder: (context) => const posaliLoginScreen(),
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
            const Spacer(),
            // Thanh dưới
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

// Widget nút đăng ký tuỳ biến
class _SignUpButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color color;
  final Color textColor;
  final IconData? icon;
  final String? iconAsset;
  final String text;
  final BorderSide border;

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
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
            side: border,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (icon != null)
              Icon(icon, color: textColor, size: 24)
            else if (iconAsset != null)
              Image.asset(iconAsset!, width: 24, height: 24),
            const SizedBox(width: 18),
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
