// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zego_express_engine/zego_express_engine.dart';
import 'home_page.dart';
import 'key_center.dart';

// Zego Express Engineの初期化を行う関数
Future<void> createEngine() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ZEGOCLOUDコンソールからAppIDとAppSignを取得します
  //[My Projects -> AppID] : https://console.zegocloud.com/project
  await ZegoExpressEngine.createEngineWithProfile(ZegoEngineProfile(
    appID,
    ZegoScenario.Default,
    appSign: kIsWeb ? null : appSign,
  ));
}

// ホームページに遷移する関数
void jumpToHomePage(
    BuildContext context, {
      required String localUserID,
      required String localUserName,
    }) async {
  await createEngine();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => HomePage(
        localUserID: localUserID,
        localUserName: localUserName,
      ),
    ),
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  /// 同じroomIDを使用するユーザーは同じライブストリーミングに参加できます。
  final userIDTextCtrl = TextEditingController(text: Random().nextInt(100000).toString());
  final userNameTextCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    userNameTextCtrl.text = 'ユーザー_${userIDTextCtrl.text}';
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      fixedSize: const Size(120, 60),
      backgroundColor: const Color(0xff2C2F3E).withOpacity(0.6),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('2台以上のデバイスでテストしてください'),
            const Divider(),
            TextFormField(
              controller: userIDTextCtrl,
              decoration: const InputDecoration(labelText: 'ユーザーID'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: userNameTextCtrl,
              decoration: const InputDecoration(labelText: 'ユーザー名'),
            ),
            const SizedBox(height: 20),
            // ログインページからホームページに遷移するためのボタン
            ElevatedButton(
              style: buttonStyle,
              child: const Text('ログイン',style: TextStyle(color: Colors.white)),
              onPressed: () => jumpToHomePage(
                context,
                localUserID: userIDTextCtrl.text,
                localUserName: userNameTextCtrl.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
