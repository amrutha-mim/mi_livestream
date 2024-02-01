// このDartファイルは、ギフトプロトコルに関するもので、プロトコルの実装とギフトの送受信に関連するコードを含んでいます。

// 必要なライブラリとパッケージをインポートします。
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:zego_uikit/zego_uikit.dart';

// ギフトマネージャーのプロトコルに関する機能を提供するパーツを含むパーツをインポートします。
part of 'gift_manager.dart';

// GiftProtocolのミックスインを定義します。
mixin GiftProtocol {
  // GiftProtocolImplのインスタンスを作成します。
  final _giftProtocolImpll = GiftProtocolImpll();
  GiftProtocolImpll get service => _giftProtocolImpll;
}

// プロトコルの実装を行うGiftProtocolImpllクラスを定義します。
class GiftProtocolImpll {
  // アプリID、ライブID、ローカルユーザーID、ローカルユーザー名を格納する変数を宣言します。
  late int _appID;
  late String _liveID;
  late String _localUserID;
  late String _localUserName;

  // StreamSubscriptionを格納するリストです。
  final List<StreamSubscription<dynamic>?> _subscriptions = [];

  // ギフトの受信を通知するValueNotifierです。
  final recvNotifier = ValueNotifier<ZegoGiftProtocolItem?>(null);

  // 初期化メソッドです。
  void init({
    required int appID,
    required String liveID,
    required String localUserID,
    required String localUserName,
  }) {
    _appID = appID;
    _liveID = liveID;
    _localUserID = localUserID;
    _localUserName = localUserName;

    // サービスが提供するSignalingPluginからのイベントを購読します。
    _subscriptions.add(ZegoUIKit()
        .getSignalingPlugin()
        .getInRoomCommandMessageReceivedEventStream()
        .listen((event) {
      onInRoomCommandMessageReceived(event);
    }));
  }

  // 終了処理メソッドです。
  void uninit() {
    // 登録したイベントの購読を解除します。
    for (final subscription in _subscriptions) {
      subscription?.cancel();
    }
    // メディアプレーヤーを破棄します。
    GiftMp4Player().destroyMediaPlayer();
  }

  // ギフトを送信します。
  Future<bool> sendGift({
    required String name,
    required int count,
  }) async {
    // ギフトデータをJSON形式にエンコードします。
    final data = ZegoGiftProtocol(
      appID: _appID,
      liveID: _liveID,
      localUserID: _localUserID,
      localUserName: _localUserName,
      giftItem: ZegoGiftProtocolItem(
        name: name,
        count: count,
      ),
    ).toJson();

    // サーバーAPIを使用せずに、デモ用に同期的に表示するためのメッセージを送信します。
    // 実際のビジネスロジックには、ZIMCommandMessageタイプのメッセージを送信するために
    // サーバーAPIを使用してください。
    // https://docs.zegocloud.com/article/16201
    debugPrint('! ${'*' * 80}');
    debugPrint('! ** 警告: これはデモで同期的な表示効果のためのものです。');
    debugPrint('! ** ');
    debugPrint('! ** 請求やビジネスロジックに関連する場合は、');
    debugPrint('! ** サーバーAPIを使用してZIMCommandMessageタイプのメッセージを送信してください。');
    debugPrint('! ${'*' * 80}');

    debugPrint('try send gift, name:$name, count:$count, data:$data');

    // InRoomCommandMessageを送信します。
    ZegoUIKit()
        .getSignalingPlugin()
        .sendInRoomCommandMessage(
      roomID: _liveID,
      message: _stringToUint8List(data),
    )
        .then((result) {
      debugPrint('send gift result:$result');
    });

    return true;
  }

  // StringをUint8Listに変換するメソッドです。
  Uint8List _stringToUint8List(String input) {
    List<int> utf8Bytes = utf8.encode(input);
    Uint8List uint8List = Uint8List.fromList(utf8Bytes);
    return uint8List;
  }

  // InRoomCommandMessageを受信した際の処理メソッドです。
  void onInRoomCommandMessageReceived(ZegoSignalingPluginInRoomCommandMessageReceivedEvent event) {
    final messages = event.messages;

    // ユーザーごとに異なるアニメーションを表示できます。
    for (final commandMessage in messages) {
      final senderUserID = commandMessage.senderUserID;
      final message = utf8.decode(commandMessage.message);
      debugPrint('onInRoomCommandMessageReceived: $message');
      if (senderUserID != _localUserID) {
        final gift = ZegoGiftProtocol.fromJson(message);
        recvNotifier.value = gift.giftItem;
      }
    }
  }
}

// ギフトプロトコルのデータクラスです。
class ZegoGiftProtocolItem {
  String name = '';
  int count = 0;

  ZegoGiftProtocolItem({
    required this.name,
    required this.count,
  });

  ZegoGiftProtocolItem.empty();
}

// ギフトプロトコルのクラスです。
class ZegoGiftProtocol {
  int appID = 0;
  String liveID = '';
  String localUserID = '';
  String localUserName = '';
  ZegoGiftProtocolItem giftItem;

  ZegoGiftProtocol({
    required this.appID,
    required this.liveID,
    required this.localUserID,
    required this.localUserName,
    required this.giftItem,
  });

  // JSON形式の文字列を返すメソッドです。
  String toJson() => json.encode({
  'app_id': appID,
    'room_id': liveID,
    'user_id': localUserID,
    'user_name': localUserName,
    'gift_name': giftItem.name,
    'gift_count': giftItem.count,
    'timestamp': DateTime.now().millisecondsSinceEpoch,
  });

  // JSON形式の文字列をデコードしてZegoGiftProtocolオブジェクトを生成するファクトリメソッドです。
  factory ZegoGiftProtocol.fromJson(String jsonData) {
    Map<String, dynamic> json = {};
    try {
      json = jsonDecode(jsonData) as Map<String, dynamic>? ?? {};
    } catch (e) {
      debugPrint('protocol data is not json:$jsonData');
    }
    return ZegoGiftProtocol(
      appID: json['app_id'] ?? 0,
      liveID: json['room_id'] ?? '',
      localUserID: json['user_id'] ?? '',
      localUserName: json['user_name'] ?? '',
      giftItem: ZegoGiftProtocolItem(
        name: json['gift_name'] ?? 0,
        count: json['gift_count'] ?? 0,
      ),
    );
  }
}
