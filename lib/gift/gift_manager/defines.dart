class ZegoGiftItem {
  String name;
  String icon;
  String sourceURL;
  ZegoGiftSource source;
  ZegoGiftType type;
  int weight;

  ZegoGiftItem({
    required this.sourceURL,
    required this.weight,
    this.name = '',
    this.icon = '',
    this.source = ZegoGiftSource.url,
    this.type = ZegoGiftType.svga,
  });
}

// ギフトのソース種別
enum ZegoGiftSource {
  url,   // ウェブ上のURLから
  asset, // アプリ内のアセットから
}

// ギフトの種別
enum ZegoGiftType {
  svga, // SVGA形式のアニメーション
  mp4,  // MP4形式のアニメーション
}

class PlayData {
  ZegoGiftItem giftItem; // ギフトアイテム
  int count;             // ギフトの再生回数

  PlayData({
    required this.giftItem,
    this.count = 1,
  });
}
