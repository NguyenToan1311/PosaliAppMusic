import 'package:flutter/material.dart';

final List<Map<String, dynamic>> playlists = [
  {
    "title": "Bài hát ưa thích",
    "subtitle": "Danh sách phát · 65 bài hát",
    "icon": Icons.favorite,
    "color": Colors.purpleAccent,
    "isIcon": true,
  },
  {
    "title": "NHAC RAP",
    "subtitle": "Danh sách phát · Nguyentoan",
    "image": "https://picsum.photos/seed/nhacrap/50/50",
  },
  {
    "title": "KHÔNG CHILL KHÔNG CHILL",
    "subtitle": "Danh sách phát · Nguyentoan",
    "image": "https://picsum.photos/seed/chill1/50/50",
  },
  {
    "title": "KHÔNG XUNG KHÔNG RUNG",
    "subtitle": "Danh sách phát · Nguyentoan",
    "image": "https://picsum.photos/seed/chill2/50/50",
  },
  {
    "title": "FOCUS",
    "subtitle": "Danh sách phát · Nguyentoan",
    "image": "https://picsum.photos/seed/focus/50/50",
  },
  {
    "title": "old music",
    "subtitle": "Danh sách phát · Nguyentoan",
    "image": "https://picsum.photos/seed/old/50/50",
  },
  {
    "title": "International Music",
    "subtitle": "Danh sách phát · Nguyentoan",
    "image": "https://picsum.photos/seed/international/50/50",
  },
  {
    "title": "Dạ cổ",
    "subtitle": "Danh sách phát · Nguyentoan",
    "image": "https://picsum.photos/seed/daco/50/50",
  },
  {
    "title": "女儿心",
    "subtitle": "Danh sách phát · Nguyentoan",
    "image": "https://picsum.photos/seed/girl/50/50",
  },
  {
    "title": "Kpopopop",
    "subtitle": "Danh sách phát · Nguyentoan",
    "image": "https://picsum.photos/seed/kpop/50/50",
  },
  {
    "title": "RAPOLD",
    "subtitle": "Danh sách phát · Nguyemtoan",
    "image": "https://picsum.photos/seed/rapold/50/50",
  },
];

class DiscoveryTab extends StatelessWidget {
  const DiscoveryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191919),
      appBar: AppBar(
        backgroundColor: const Color(0xFF191919),
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage("assets/profile.png"),
            ),
            const SizedBox(width: 12),
            const Text(
              "Thư viện",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Button group
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                _buildTopButton("Danh sách phát", true),
                const SizedBox(width: 10),
                _buildTopButton("Đã tải xuống", false),
              ],
            ),
          ),
          // Recently section
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 6, top: 4),
            child: Row(
              children: [
                const Icon(Icons.history, color: Colors.white54, size: 18),
                const SizedBox(width: 8),
                const Text("Gần đây", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.grid_view_rounded, color: Colors.white54, size: 22),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white54, size: 22),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // Scrollable List
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ...playlists.map((item) => _buildPlaylistTile(item)),
                const Divider(color: Colors.white10, height: 24, thickness: 1, indent: 16, endIndent: 16),
                _buildMenuItem(Icons.queue_music_rounded, "Tệp trên máy", "0 bài nhạc"),
                _buildMenuItem(Icons.add_circle_outline_rounded, "Thêm nghệ sĩ", ""),
                _buildMenuItem(Icons.podcasts, "Thêm podcast và chương trình", ""),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopButton(String label, bool selected) {
    return Expanded(
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: selected ? Colors.white12 : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white12),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaylistTile(Map<String, dynamic> item) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: item["isIcon"] == true
          ? CircleAvatar(
              backgroundColor: item["color"] ?? Colors.blue,
              child: Icon(item["icon"], color: Colors.white),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item["image"],
                width: 46,
                height: 46,
                fit: BoxFit.cover,
              ),
            ),
      title: Text(
        item["title"],
        style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16, height: 1.15,
        ),
      ),
      subtitle: Text(
        item["subtitle"] ?? "",
        style: const TextStyle(color: Colors.white54, fontSize: 13),
      ),
      onTap: () {},
      minLeadingWidth: 0,
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Icon(icon, size: 34, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
      subtitle: subtitle.isNotEmpty
          ? Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 13))
          : null,
      onTap: () {},
      minLeadingWidth: 0,
    );
  }
}