import 'dart:math';
import 'package:appnghenhac/data/model/song.dart';
import 'package:appnghenhac/ui/now_playing/audio_player_manager.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({super.key, required this.playingSong, required this.songs});
  final Song playingSong;
  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return NowPlayingPage(songs: songs, playingSong: playingSong);
  }
}

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({
    super.key,
    required this.songs,
    required this.playingSong,
  });
  final Song playingSong;
  final List<Song> songs;

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _imageAnimController;
  late AudioPlayerManager _audioPlayerManager;
  late int _selectedItemIndex;
  late Song _song;
  bool _isShuffle = false;
  late LoopMode _loopMode;
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _song = widget.playingSong;
    _selectedItemIndex = widget.songs.indexOf(widget.playingSong);
    _imageAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 12000),
    );
    _audioPlayerManager = AudioPlayerManager();
    _loopMode = LoopMode.off;

    _maybePrepareSong();

    _audioPlayerManager.player.playerStateStream.listen((playerState) {
      if (_disposed) return;
      final playing = playerState.playing;
      final processingState = playerState.processingState;
      if (playing && processingState != ProcessingState.completed) {
        _startImageRotation();
      } else {
        _stopImageRotation();
      }
      // Tự động next khi hết bài
      if (processingState == ProcessingState.completed) {
        if (_loopMode != LoopMode.one) {
          _setNextSong();
        } else {
          _audioPlayerManager.player.seek(Duration.zero);
          _audioPlayerManager.player.play();
        }
      }
    });
  }

  // Chỉ thực sự đổi bài khi chọn sang bài mới
  Future<void> _maybePrepareSong() async {
    // Nếu trùng bài đang phát thì không reset player, không play lại
    final isSameSong =
        _audioPlayerManager.currentSongSource == _song.source;
    if (!isSameSong) {
      await _audioPlayerManager.updateSongUrl(_song.source);
      await _audioPlayerManager.prepare(isNewSong: true);
      await _audioPlayerManager.player.play();
      if (mounted && !_disposed) setState(() {});
      _startImageRotation();
    }
    // Nếu là cùng bài hát, không reset, không play lại!
  }

  @override
  void dispose() {
    _disposed = true;
    _imageAnimController.dispose();
    super.dispose();
  }

  void _startImageRotation() {
    if (!mounted || _disposed) return;
    _imageAnimController.forward(from: _imageAnimController.value);
    _imageAnimController.repeat();
  }

  void _stopImageRotation() {
    if (!mounted || _disposed) return;
    _imageAnimController.stop();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = screenWidth * 0.7;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: SizedBox(
                height: 86,
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Nhạc miễn phí',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              _song.album,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 2,
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 22),
                        onPressed: () => Navigator.of(context).maybePop(),
                        splashRadius: 22,
                        color: Colors.black,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        icon: const Icon(Icons.more_horiz),
                        onPressed: () {},
                        splashRadius: 24,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Divider
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                '— —— —',
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 5,
                  color: Colors.black38,
                ),
              ),
            ),
            // Song image
            Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 12),
              child: RotationTransition(
                turns: _imageAnimController,
                child: Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/ITunes_12.2_logo.png',
                      image: _song.image,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/ITunes_12.2_logo.png',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            // Song info, share, like
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.share_outlined),
                    color: Colors.black54,
                    splashRadius: 22,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          _song.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _song.artist,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border),
                    color: Colors.blueAccent,
                    splashRadius: 22,
                  ),
                ],
              ),
            ),
            // Progress bar
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 40),
              child: _progressBar(),
            ),
            // Controls
            const SizedBox(height: 12),
            _mediaButtons(),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _mediaButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MediaButtonControl(
            function: _setShuffle,
            icon: Icons.shuffle,
            color: _getShuffleColor(),
            size: 28,
          ),
          MediaButtonControl(
            function: _setPrevSong,
            icon: Icons.skip_previous,
            color: Colors.black,
            size: 44,
          ),
          _playButton(),
          MediaButtonControl(
            function: _setNextSong,
            icon: Icons.skip_next,
            color: Colors.black,
            size: 44,
          ),
          MediaButtonControl(
            function: _setupRepeatOption,
            icon: _repeatingIcon(),
            color: _getRepeatingIconColor(),
            size: 28,
          ),
        ],
      ),
    );
  }

  StreamBuilder<DurationState> _progressBar() {
    return StreamBuilder<DurationState>(
      stream: _audioPlayerManager.durationState,
      builder: (context, snapshot) {
        final durationState = snapshot.data;
        final progress = durationState?.progress ?? Duration.zero;
        final buffered = durationState?.buffered ?? Duration.zero;
        final total = durationState?.total ?? Duration.zero;
        return ProgressBar(
          progress: progress,
          total: total,
          buffered: buffered,
          onSeek: (duration) async {
            await _audioPlayerManager.player.seek(duration);
          },
          barHeight: 5.0,
          barCapShape: BarCapShape.round,
          baseBarColor: Colors.grey.withOpacity(0.3),
          progressBarColor: Colors.blueAccent,
          bufferedBarColor: Colors.grey.withOpacity(0.3),
          thumbColor: Colors.blueAccent,
          thumbGlowColor: Colors.blueAccent.withOpacity(0.3),
          thumbRadius: 10.0,
        );
      },
    );
  }

  StreamBuilder<PlayerState> _playButton() {
    return StreamBuilder<PlayerState>(
      stream: _audioPlayerManager.player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing ?? false;

        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return Container(
            margin: const EdgeInsets.all(8),
            width: 60,
            height: 60,
            child: const CircularProgressIndicator(),
          );
        } else if (!playing) {
          return MediaButtonControl(
            function: () async {
              await _audioPlayerManager.player.play();
              if (mounted && !_disposed) setState(() {});
            },
            icon: Icons.play_arrow,
            color: Colors.white,
            size: 56,
            fill: true,
          );
        } else if (processingState != ProcessingState.completed) {
          return MediaButtonControl(
            function: () {
              _audioPlayerManager.player.pause();
              if (mounted && !_disposed) setState(() {});
            },
            icon: Icons.pause,
            color: Colors.white,
            size: 56,
            fill: true,
          );
        } else {
          // Replay button: chỉ reset khi đã completed, các lần bấm khi đang phát lại thì không reset nữa
          return MediaButtonControl(
            function: () {
              if (processingState == ProcessingState.completed) {
                _audioPlayerManager.player.seek(Duration.zero);
                _audioPlayerManager.player.play();
                if (mounted && !_disposed) setState(() {});
              }
            },
            icon: Icons.replay,
            color: Colors.white,
            size: 56,
            fill: true,
          );
        }
      },
    );
  }

  void _setShuffle() {
    setState(() {
      _isShuffle = !_isShuffle;
    });
  }

  Color? _getShuffleColor() {
    return _isShuffle ? Colors.blueAccent : Colors.grey[400];
  }

  void _setNextSong() async {
    if (widget.songs.isEmpty) return;
    if (_isShuffle) {
      var random = Random();
      _selectedItemIndex = random.nextInt(widget.songs.length);
    } else if (_selectedItemIndex < widget.songs.length - 1) {
      ++_selectedItemIndex;
    } else if (_loopMode == LoopMode.all &&
        _selectedItemIndex == widget.songs.length - 1) {
      _selectedItemIndex = 0;
    }
    if (_selectedItemIndex >= widget.songs.length) {
      _selectedItemIndex = _selectedItemIndex % widget.songs.length;
    }
    final nextSong = widget.songs[_selectedItemIndex];

    setState(() {
      _song = nextSong;
    });

    final isSameSong = _audioPlayerManager.currentSongSource == nextSong.source;
    if (!isSameSong) {
      await _audioPlayerManager.updateSongUrl(nextSong.source);
      await _audioPlayerManager.prepare(isNewSong: true);
      await _audioPlayerManager.player.play();
    }
    _startImageRotation();
  }

  void _setPrevSong() async {
    if (widget.songs.isEmpty) return;
    if (_isShuffle) {
      var random = Random();
      _selectedItemIndex = random.nextInt(widget.songs.length);
    } else if (_selectedItemIndex > 0) {
      --_selectedItemIndex;
    } else if (_loopMode == LoopMode.all && _selectedItemIndex == 0) {
      _selectedItemIndex = widget.songs.length - 1;
    }
    if (_selectedItemIndex < 0) {
      _selectedItemIndex = (-1 * _selectedItemIndex) % widget.songs.length;
    }
    final prevSong = widget.songs[_selectedItemIndex];

    setState(() {
      _song = prevSong;
    });

    final isSameSong = _audioPlayerManager.currentSongSource == prevSong.source;
    if (!isSameSong) {
      await _audioPlayerManager.updateSongUrl(prevSong.source);
      await _audioPlayerManager.prepare(isNewSong: true);
      await _audioPlayerManager.player.play();
    }
    _startImageRotation();
  }

  IconData _repeatingIcon() {
    switch (_loopMode) {
      case LoopMode.one:
        return Icons.repeat_one;
      case LoopMode.all:
        return Icons.repeat_on;
      default:
        return Icons.repeat;
    }
  }

  Color? _getRepeatingIconColor() {
    return _loopMode == LoopMode.off ? Colors.grey[400] : Colors.blueAccent;
  }

  void _setupRepeatOption() {
    setState(() {
      if (_loopMode == LoopMode.off) {
        _loopMode = LoopMode.one;
      } else if (_loopMode == LoopMode.one) {
        _loopMode = LoopMode.all;
      } else {
        _loopMode = LoopMode.off;
      }
      _audioPlayerManager.player.setLoopMode(_loopMode);
    });
  }
}

class MediaButtonControl extends StatelessWidget {
  const MediaButtonControl({
    super.key,
    required this.function,
    required this.icon,
    required this.color,
    required this.size,
    this.fill = false,
  });
  final void Function()? function;
  final IconData icon;
  final double? size;
  final Color? color;
  final bool fill;

  @override
  Widget build(BuildContext context) {
    if (fill) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          onPressed: function,
          icon: Icon(icon),
          iconSize: size ?? 40,
          color: color ?? Colors.white,
          splashRadius: (size ?? 40) / 2 + 6,
        ),
      );
    }
    return IconButton(
      onPressed: function,
      icon: Icon(icon),
      iconSize: size ?? 28,
      color: color ?? Colors.black54,
      splashRadius: (size ?? 28) / 2 + 6,
    );
  }
}