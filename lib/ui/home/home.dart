import 'package:appnghenhac/data/model/song.dart';
import 'package:appnghenhac/ui/discovery/discovery.dart';
import 'package:appnghenhac/ui/home/viewmodel.dart';
import 'package:appnghenhac/ui/now_playing/audio_player_manager.dart';
import 'package:appnghenhac/ui/now_playing/playing.dart';
import 'package:appnghenhac/ui/settings/settings.dart';
import 'package:appnghenhac/ui/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Posali extends StatelessWidget {
  const Posali({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posali',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true, 
      ),
      home: const MusicHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MusicHomePage extends StatefulWidget {
  const MusicHomePage({super.key});

  @override
  State<MusicHomePage> createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  final List<Widget> _tabs = [
    const HomeTab(),
    const DiscoveryTab(),
    const AccountTab(),
    const SettingsTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Replace "assets/posali_logo.png" with your asset path or use NetworkImage if needed
            Image.asset(
              'assets/ITunes_12.2_logo.png',
              width: 32,
              height: 32,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            const Text(
              'POSALI',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.album), label: 'Discovery'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ), 
        tabBuilder: (BuildContext context, int index) {
          return _tabs[index];
        },
      ),
    );  
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeTabPage();
  }
}

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  List<Song> songs = [];
  late PosaliViewModel _viewModel;

  @override
  void initState() {
    _viewModel = PosaliViewModel();
    _viewModel.loadSongs();
    observeData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    bool showLoading = songs.isEmpty;
    if (showLoading){
      return getProgressBar();
    } else {
      return getListView();
    }
  }

  @override
  void dispose(){
    _viewModel.songStream.close();
    AudioPlayerManager().dispose();
    super.dispose();
  }

  Widget getProgressBar(){
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  ListView getListView() {
    return ListView.separated(
      itemBuilder: (context, position){
        return getRow(position);
      },
      separatorBuilder: (context, index){
        return const Divider(
          color: Colors.grey,
          thickness: 1,
          indent: 24,
          endIndent: 24,
        );
      },
      itemCount: songs.length, 
      shrinkWrap: true,
    );
  }

  Widget getRow(int index) {
    return _SongItemSection(parent: this, 
      song: songs[index], 
    );
  }
  void observeData(){
    _viewModel.songStream.stream.listen((songList) {
      setState(() {
        songs.addAll(songList);
      });
    });
  }

  void showBottomSheet() {
    showModalBottomSheet(context: context, builder: (context) {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        child: Container(
          height: 400,
          color: Colors.lightBlueAccent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Tải xuống'),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context), 
                  child: const Text('Thêm vào thư viện'), 
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  void navigate(Song song) {
    Navigator.push(context,
      CupertinoPageRoute(builder: (context) {
        return NowPlaying(
          songs: songs,
          playingSong: song,
        );
      })
    );
  }
}

class _SongItemSection extends StatelessWidget {
  const _SongItemSection({
    required this.parent,
    required this.song,
  });
  final _HomeTabPageState parent;
  final Song song;
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(
        left: 24,
        right: 8,
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/ITunes_12.2_logo.png', 
          image: song.image,
          width: 48,
          height: 48,
          imageErrorBuilder: (context, error, stackTrace){
            return Image.asset(
              'assets/ITunes_12.2_logo.png',
              width: 48,
              height: 48,
            );
          }
        ),
      ),
      title: Text(song.title),
      subtitle: Text(song.artist),
      trailing: IconButton(
        icon: const Icon(Icons.more_horiz),
        onPressed: () {
          parent.showBottomSheet();
        },
      ),
      onTap: () {
        parent.navigate(song);
      },
    );
  }
}