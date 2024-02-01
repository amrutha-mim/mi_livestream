// Dartのインポート:
import 'dart:math';

// Flutterのインポート:
import 'package:flutter/material.dart';

import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

// プロジェクトのインポート:
import 'constants.dart';
import 'live_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.localUserID, required this.localUserName}) : super(key: key);

  final String localUserID;
  final String localUserName;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 同じライブIDを使用するユーザーは同じライブストリーミングに参加できます。
  final liveTextCtrl =
  TextEditingController(text: Random().nextInt(10000).toString());

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      fixedSize: const Size(200, 60),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('2台以上のデバイスでテストしてください'),
            const Divider(),
            Text('ユーザーID:${widget.localUserID}'),
            const SizedBox(height: 20),
            Text('ユーザー名:${widget.localUserName}'),
            const SizedBox(height: 20),

            TextFormField(
              controller: liveTextCtrl,
              decoration: const InputDecoration(labelText: 'ライブIDを使用して参加する'),
            ),
            const SizedBox(height: 20),
            // ライブページに移動するためのボタン
            ElevatedButton(
              style: buttonStyle,
              child: const Text('ライブを始めてください'),
              onPressed: () {
                if (ZegoUIKitPrebuiltLiveStreamingController()
                    .minimize
                    .isMinimizing) {
                  /// アプリケーションが最小化されている場合、
                  /// 複数のPrebuiltLiveStreamingコンポーネントが作成されるのを防ぐために、ボタンクリックを無効にします。
                  return;
                }

                jumpToLivePage(
                  context,
                  liveID: liveTextCtrl.text,
                  isHost: true,
                );
              },
            ),
            const SizedBox(height: 20),
            // ライブページに移動するためのボタン
            ElevatedButton(
              style: buttonStyle,
              child: const Text('ぜひライブを見てください'),
              onPressed: () {
                if (ZegoUIKitPrebuiltLiveStreamingController()
                    .minimize
                    .isMinimizing) {
                  /// アプリケーションが最小化されている場合、
                  /// 複数のPrebuiltLiveStreamingコンポーネントが作成されるのを防ぐために、ボタンクリックを無効にします。
                  return;
                }

                jumpToLivePage(
                  context,
                  liveID: liveTextCtrl.text,
                  isHost: false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void jumpToLivePage(BuildContext context,
      {required String liveID, required bool isHost}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LivePage(
          liveID: liveID,
          isHost: isHost,
        ),
      ),
    );
  }
}
