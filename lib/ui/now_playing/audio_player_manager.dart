import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerManager {
  // Singleton pattern
  static final AudioPlayerManager _instance = AudioPlayerManager._internal();
  factory AudioPlayerManager() => _instance;
  AudioPlayerManager._internal();

  final AudioPlayer player = AudioPlayer();
  late final Stream<DurationState> durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
    player.positionStream,
    player.playbackEventStream,
    (position, playbackEvent) => DurationState(
      progress: position,
      buffered: playbackEvent.bufferedPosition,
      total: playbackEvent.duration,
    ),
  ).asBroadcastStream();

  String songUrl = "";
  String currentSongSource = ""; // Lưu lại source của bài hát hiện tại
  bool _isLoading = false;

  /// Chuẩn bị nhạc, reset progress bar và tự động play nếu là bài mới
  /// Chỉ reset nếu là bài mới (source khác)
  Future<void> prepare({bool isNewSong = false}) async {
    if (isNewSong) {
      try {
        if (_isLoading) return;
        _isLoading = true;
        await player.stop();
        await player.setUrl(songUrl);
        currentSongSource = songUrl; // Lưu lại bài đang phát (để so sánh ở UI)
        await player.seek(Duration.zero);
        await player.play();
      } catch (e) {
        print('AudioPlayerManager.prepare error: $e');
      } finally {
        _isLoading = false;
      }
    }
  }

  /// Đổi bài mới và chờ load hoàn tất (không reset nếu là bài đang phát)
  Future<void> updateSongUrl(String url) async {
    songUrl = url;
    try {
      if (_isLoading) return;
      _isLoading = true;
      await player.stop();
      await player.setUrl(songUrl);
      // Không cập nhật currentSongSource ở đây, chỉ cập nhật khi thực sự play bài mới
    } catch (e) {
      print('AudioPlayerManager.updateSongUrl error: $e');
    } finally {
      _isLoading = false;
    }
  }

  /// Không dispose ở màn NowPlaying, chỉ dispose khi app thoát hẳn
  void dispose() {
    player.dispose();
  }
}

class DurationState {
  const DurationState({
    required this.progress,
    required this.buffered,
    this.total,
  });
  final Duration progress;
  final Duration buffered;
  final Duration? total;
}