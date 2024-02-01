// このDartファイルは、ギフトプレイリストに関するもので、プレイリストの実装を含んでいます。

// 必要なライブラリとパッケージをインポートします。
import 'package:flutter/cupertino.dart';

// ギフトマネージャーのプレイリストに関する機能を提供するパーツを含むパーツをインポートします。
part of 'gift_manager.dart';

// GiftPlayListのミックスインを定義します。
mixin GiftPlayList {
  // PlayListImplのインスタンスを作成します。
  final _playListImpl = PlayListImpl();

  // PlayListImplのゲッターを提供します。
  PlayListImpl get playList => _playListImpl;
}

// プレイリストの実装を行うPlayListImplクラスを定義します。
class PlayListImpl {
  // 現在再生中のデータを通知するValueNotifierです。
  final playingDataNotifier = ValueNotifier<PlayData?>(null);

  // 保留中のプレイリストを格納するリストです。
  List<PlayData> pendingPlaylist = [];

  // プレイリストから次のデータを取得し、通知します。
  void next() {
    if (pendingPlaylist.isEmpty) {
      playingDataNotifier.value = null;
    } else {
      playingDataNotifier.value = pendingPlaylist.removeAt(0);
    }
  }

  // プレイデータをプレイリストに追加します。
  void add(PlayData data) {
    if (playingDataNotifier.value != null) {
      pendingPlaylist.add(data);
      return;
    }
    playingDataNotifier.value = data;
  }

  // プレイリストをクリアします。
  bool clear() {
    playingDataNotifier.value = null;
    pendingPlaylist.clear();

    return true;
  }
}
