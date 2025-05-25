import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appnghenhac/ui/loginsignup.dart';
import 'package:appnghenhac/ui/home/home.dart'; // Import trang Home (đảm bảo đúng path)

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  // Hàm xử lý đăng xuất: Đóng dialog rồi chuyển màn hình
  Future<void> _handleLogout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // Chờ dialog đóng xong rồi push màn hình đăng nhập
    Future.delayed(Duration.zero, () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const SpotifyIntroScreen()),
        (route) => false,
      );
    });
  }

  // Hàm hiển thị dialog xác nhận đăng xuất
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => Dialog(
        backgroundColor: const Color(0xFF232323),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Đăng xuất tài khoản này?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9B5DF7),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () async {
                    Navigator.of(dialogContext).pop(); // Đóng dialog trước
                    await _handleLogout(context); // Rồi mới logout và chuyển màn hình
                  },
                  child: const Text(
                    "ĐĂNG XUẤT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => Navigator.of(dialogContext).pop(), // Chỉ đóng dialog, không làm gì
                child: const Text(
                  "HỦY",
                  style: TextStyle(
                    color: Color(0xFF9B5DF7),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      appBar: AppBar(
        backgroundColor: const Color(0xFF181818),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            // Quay lại trang Home
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const Posali()), // Đổi thành widget home của bạn
              (route) => false,
            );
          },
        ),
        title: const Text(
          "Thiết lập",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _SettingsSection(
                items: [
                  _SettingsItem(icon: Icons.music_note, title: "Trình phát nhạc"),
                  _SettingsItem(
                    icon: Icons.color_lens_outlined,
                    title: "Giao diện chủ đề",
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text("MỚI", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white38),
                      ],
                    ),
                  ),
                  _SettingsItem(icon: Icons.download_outlined, title: "Tải nhạc"),
                  _SettingsItem(icon: Icons.offline_pin_outlined, title: "Offline Mix"),
                  _SettingsItem(icon: Icons.library_music_outlined, title: "Thư viện"),
                  _SettingsItem(icon: Icons.video_library_outlined, title: "Video"),
                  _SettingsItem(icon: Icons.headphones_outlined, title: "Tai nghe và Bluetooth"),
                  _SettingsItem(icon: Icons.notifications_outlined, title: "Thông báo"),
                ],
              ),
              _SettingsSection(
                items: [
                  _SettingsItem(
                    icon: Icons.system_update_outlined,
                    title: "Kiểm tra phiên bản mới",
                    trailing: const Text(
                      "25.04",
                      style: TextStyle(color: Colors.white38, fontSize: 13),
                    ),
                  ),
                  _SettingsItem(icon: Icons.help_outline, title: "Trợ giúp và báo lỗi"),
                  _SettingsItem(icon: Icons.star_border, title: "Bình chọn cho Zing MP3"),
                  _SettingsItem(icon: Icons.article_outlined, title: "Điều khoản sử dụng"),
                  _SettingsItem(icon: Icons.privacy_tip_outlined, title: "Chính sách bảo mật"),
                ],
              ),
              _SettingsSection(
                items: [
                  _SettingsItem(icon: Icons.category_outlined, title: "Khác"),
                  _SettingsItem(
                    icon: Icons.logout,
                    title: "Đăng xuất tài khoản",
                    iconColor: Colors.redAccent,
                    textColor: Colors.redAccent,
                    onTap: () => _showLogoutDialog(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final List<_SettingsItem> items;
  const _SettingsSection({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF232323),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFF323232)),
        itemBuilder: (context, i) => items[i],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final Color? iconColor;
  final Color? textColor;
  final VoidCallback? onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    this.trailing,
    this.iconColor,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Colors.white, size: 28),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing ??
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white38),
      onTap: onTap,
    );
  }
}