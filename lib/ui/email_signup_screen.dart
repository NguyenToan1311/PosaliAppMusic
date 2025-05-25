import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'new_login.dart'; // Đảm bảo tên file và widget đúng

class EmailSignUpScreen extends StatefulWidget {
  const EmailSignUpScreen({super.key});

  @override
  State<EmailSignUpScreen> createState() => _EmailSignUpScreenState();
}

class _EmailSignUpScreenState extends State<EmailSignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading = false;
  String errorMessage = '';

  Future<void> signUpWithEmail() async {
    final email = emailController.text.trim();
    final username = usernameController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    // Kiểm tra dữ liệu nhập
    if (email.isEmpty || username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      setState(() => errorMessage = 'Vui lòng nhập đầy đủ thông tin');
      return;
    }
    if (password.length < 6) {
      setState(() => errorMessage = 'Mật khẩu phải từ 6 ký tự trở lên');
      return;
    }
    if (password != confirmPassword) {
      setState(() => errorMessage = 'Mật khẩu nhập lại không khớp');
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      // Đăng ký tài khoản Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Lưu thông tin user lên Firebase Database
      final userId = userCredential.user?.uid;
      if (userId != null) {
        DatabaseReference ref = FirebaseDatabase.instance.ref("users/$userId");
        await ref.set({
          "username": username,
          "email": email,
        });
      }
      if (mounted) {
        // Lưu lại context màn hình cha
        final parentContext = context;
        showDialog(
          context: parentContext,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            title: const Text("Đăng ký thành công"),
            content: const Text("Bạn đã đăng ký thành công!"),
            actions: [
              TextButton(
                onPressed: () {
                  // Đóng dialog trước
                  Navigator.of(parentContext, rootNavigator: true).pop();
                  // Đợi dialog đóng hoàn toàn rồi mới chuyển màn đăng nhập
                  Future.delayed(Duration.zero, () {
                    Navigator.of(parentContext).pushReplacement(
                      MaterialPageRoute(builder: (_) => const NewLoginScreen()),
                    );
                  });
                },
                child: const Text("Đi đến đăng nhập"),
              ),
            ],
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'Đã xảy ra lỗi';
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Lỗi không xác định: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("Đăng ký bằng Email"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white10,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: usernameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Tên người dùng',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white10,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Mật khẩu',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white10,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Nhập lại mật khẩu',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white10,
                  ),
                ),
                const SizedBox(height: 24),
                if (errorMessage.isNotEmpty)
                  Text(errorMessage, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : signUpWithEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text("Đăng ký"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}