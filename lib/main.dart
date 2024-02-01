import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';
import 'login_page.dart';
import 'gift/gift.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // アプリケーション内でのナビゲーターの状態を管理するためのキー
  final navigatorKey = GlobalKey<NavigatorState>();

  // Zego Gift Managerを初期化し、ギフトアイテムのキャッシュを行います
  ZegoGiftManager().cache.cache(giftItemList);

  // ZegoUIKitのログを初期化し、Amplifyを構成した後にアプリケーションを起動します
  ZegoUIKit().initLog().then((value) {
    runApp(MyApp(
      navigatorKey: navigatorKey,
    ));
    _configureAmplify();
  });
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({
    required this.navigatorKey,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MI ライブストリーム',
      // ログインページをホームページとして設定
      home: LoginPage(),
      navigatorKey: widget.navigatorKey,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            child!,
            // ZegoUIKitのPrebuilt Live Streamingのミニオーバーレイページ
            ZegoUIKitPrebuiltLiveStreamingMiniOverlayPage(
              contextQuery: () {
                return widget.navigatorKey.currentState!.context;
              },
            ),
          ],
        );
      },
    );
  }
}

// Amplifyを構成するための非同期関数
Future<void> _configureAmplify() async {
  // AmplifyにAmplifyAPIプラグインを追加
  Amplify.addPlugin(AmplifyAPI());
  // AmplifyDataStoreプラグインを作成し、ModelProviderを使用してモデルを提供
  final datastorePlugin =
  AmplifyDataStore(modelProvider: ModelProvider.instance);
  await Amplify.addPlugin(datastorePlugin);

  try {
    // Amplifyを構成
    await Amplify.configure(amplifyconfig);
  } on AmplifyAlreadyConfiguredException {
    safePrint(
        'Tried to reconfigure Amplify; this can occur when your app restarts on Android.');
  }
}
