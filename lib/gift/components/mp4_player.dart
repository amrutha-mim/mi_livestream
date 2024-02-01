import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zego_express_engine/zego_express_engine.dart';
import 'package:zego_uikit/zego_uikit.dart';

// ギフトMP4プレーヤークラス
class GiftMp4Player with ZegoUIKitMediaEventInterface {
// シングルトンインスタンス
static final GiftMp4Player _instance = GiftMp4Player._internal();
factory GiftMp4Player() => _instance;
GiftMp4Player._internal();

bool _registerToUIKit = false;

Widget? _mediaPlayerWidget;
ZegoMediaPlayer? _mediaPlayer;
int _mediaPlayerViewID = -1;

/// コールバック関数
void Function(ZegoMediaPlayerState state, int errorCode)? _onMediaPlayerStateUpdate;
void Function(ZegoMediaPlayerFirstFrameEvent event)? _onMediaPlayerFirstFrameEvent;

// コールバック関数の登録
void registerCallbacks({
Function(ZegoMediaPlayerState state, int errorCode)? onMediaPlayerStateUpdate,
Function(ZegoMediaPlayerFirstFrameEvent event)? onMediaPlayerFirstFrameEvent,
}) {
if (!_registerToUIKit) {
ZegoUIKit().registerMediaEvent(_instance);
_registerToUIKit = true;
}

_onMediaPlayerStateUpdate = onMediaPlayerStateUpdate;
_onMediaPlayerFirstFrameEvent = onMediaPlayerFirstFrameEvent;
}

// コールバック関数の登録解除
void unregisterCallbacks() {
_onMediaPlayerStateUpdate = null;
_onMediaPlayerFirstFrameEvent = null;
}

/// メディアプレーヤーの作成
Future<Widget?> createMediaPlayer() async {
_mediaPlayer ??= await ZegoExpressEngine.instance.createMediaPlayer();

// ウィジェットの作成
if (_mediaPlayerViewID == -1) {
_mediaPlayerWidget = await ZegoExpressEngine.instance.createCanvasView((viewID) {
_mediaPlayerViewID = viewID;
_mediaPlayer?.setPlayerCanvas(ZegoCanvas(viewID, alphaBlend: true));
});
}
return _mediaPlayerWidget;
}

@override
void onMediaPlayerStateUpdate(mediaPlayer, state, errorCode) {
_onMediaPlayerStateUpdate?.call(state, errorCode);
}

@override
void onMediaPlayerFirstFrameEvent(mediaPlayer, event) {
_onMediaPlayerFirstFrameEvent?.call(event);
}

// メディアプレーヤーの破棄
void destroyMediaPlayer() {
if (_mediaPlayer != null) {
ZegoExpressEngine.instance.destroyMediaPlayer(_mediaPlayer!);
_mediaPlayer = null;
}
destroyPlayerView();
}

// プレーヤービューの破棄
void destroyPlayerView() {
if (_mediaPlayerViewID != -1) {
ZegoExpressEngine.instance.destroyCanvasView(_mediaPlayerViewID);
_mediaPlayerViewID = -1;
}
}

// ビューのクリア
void clearView() {
_mediaPlayer?.clearView();
}

// リソースのロード
Future<int> loadResource(String url, {ZegoAlphaLayoutType layoutType = ZegoAlphaLayoutType.Left}) async {
debugPrint('MP4プレーヤー リソースのロード: $url');
int ret = -1;
if (_mediaPlayer != null) {
ZegoMediaPlayerResource source = ZegoMediaPlayerResource.defaultConfig();
source.filePath = url;
source.loadType = ZegoMultimediaLoadType.FilePath;
source.alphaLayout = layoutType;
var result = await _mediaPlayer!.loadResourceWithConfig(source);
ret = result.errorCode;
}
return ret;
}

// メディアプレーヤーの再生開始
void startMediaPlayer() {
if (_mediaPlayer != null) {
_mediaPlayer!.start();
}
}

// メディアプレーヤーの一時停止
void pauseMediaPlayer() {
if (_mediaPlayer != null) {
_mediaPlayer!.pause();
}
}

// メディアプレーヤーの再開
void resumeMediaPlayer() {
if (_mediaPlayer != null) {
_mediaPlayer!.resume();
}
}

// メディアプレーヤーの停止
void stopMediaPlayer() {
if (_mediaPlayer != null) {
_mediaPlayer!.stop();
}
}
}
