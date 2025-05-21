import 'package:appnghenhac/data/model/song.dart';
import 'package:appnghenhac/data/source/source.dart';

import 'dart:ui'; // Cho Rect, TextDirection, v.v.
import 'package:flutter/foundation.dart'; // Cho VoidCallback
import 'package:flutter/semantics.dart'; // Cho SemanticsFlag, SemanticsAction, v.v.

abstract interface class Repository {
  Future<List<Song>?> loadData();
}

class DefaultRepository implements Repository {
  final _localDataSource = LocalDataSource();
  final _remoteDataSource = RemoteDataSource();

  @override
  Future<List<Song>?> loadData() async {
    List<Song> songs = [];
    await _remoteDataSource.loadData().then((remoteSongs) {
      if(remoteSongs == null){
        _localDataSource.loadData().then((localSongs) {
          if(localSongs != null) {
            songs.addAll(localSongs);
          }
        });
      } else {
        songs.addAll(remoteSongs);
      } 
    });

    return songs;
  }

}