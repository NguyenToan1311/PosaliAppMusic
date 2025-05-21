import 'dart:async';

import 'package:appnghenhac/data/model/song.dart';
import 'package:appnghenhac/data/repository/repository.dart';
import 'package:appnghenhac/ui/home/home.dart';

class PosaliViewModel {
  StreamController<List<Song>> songStream = StreamController();
  void loadSongs() {
    final repository = DefaultRepository();
    repository.loadData().then((value) => songStream.add(value!));
  }
}