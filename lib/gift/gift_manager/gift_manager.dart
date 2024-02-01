// このDartファイルは、ギフトの管理に関するもので、キャッシュ、プロトコル処理、プレイリストを含んでいます。

// 必要なライブラリとパッケージをインポートします。
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
import 'package:zego_uikit/zego_uikit.dart';

// ギフト管理に関連するコンポーネントをインポートします。
import '../components/mp4_player.dart';

// ギフトを定義する定数と列挙型をインポートします。
import 'defines.dart';

// 特定の機能を提供するパーツを含むパーツをインポートします。
part 'gift_cache.dart';
part 'gift_protocol.dart';
part 'gift_play_list.dart';

// ZegoGiftManagerクラスのシングルトンインスタンスです。
class ZegoGiftManager with GiftCache, GiftPlayList, GiftProtocol {
  static final ZegoGiftManager _singleton = ZegoGiftManager._internal();
  factory ZegoGiftManager() => _singleton;
  ZegoGiftManager._internal();
}
