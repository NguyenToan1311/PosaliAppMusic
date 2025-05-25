import 'package:flutter/material.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy playlist data
    final playlists = [
      {
        "title": "Việt Nam",
        "subtitle": "0 lượt lưu · Nqtoan",
        "image": "assets/dsp.png", // Local asset image
        "isAsset": true,
      },
      {
        "title": "FOCUS",
        "subtitle": "0 lượt lưu · Nqtoan",
        "image": "https://i.imgur.com/4YQbqB8.jpg",
        "isAsset": false,
      },
      {
        "title": "List của emm",
        "subtitle": "0 lượt lưu · Nqtoan",
        "image": "https://i.imgur.com/9KLpDkr.jpg",
        "isAsset": false,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      body: CustomScrollView(
        slivers: [
          // Sliver appbar with gradient and profile info
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 290,
            pinned: false,
            backgroundColor: const Color(0xFF131313),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF555546), Color(0xFF131313)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 36.0, left: 10, right: 10),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                            onPressed: () => Navigator.of(context).maybePop(),
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Avatar
                    const CircleAvatar(
                      radius: 54,
                      backgroundColor: Colors.white24,
                      backgroundImage: AssetImage(
                        "assets/profile.png",
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Name
                    const Text(
                      "Nqtoan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Follower info
                    const Text(
                      "0 người theo dõi • Đang theo dõi 0",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Action buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white38),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 0),
                          ),
                          child: const Text("Chỉnh sửa", style: TextStyle(fontSize: 15)),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.share_outlined, color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_horiz, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          // Sliver list for playlists
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Danh sách phát",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...playlists.map(
                    (playlist) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: playlist["isAsset"] == true
                                ? Image.asset(
                                    playlist["image"] as String,
                                    width: 54,
                                    height: 54,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    playlist["image"] as String,
                                    width: 54,
                                    height: 54,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                playlist["title"] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                playlist["subtitle"] as String,
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white38),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      ),
                      child: const Text(
                        "Xem tất cả danh sách phát",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}