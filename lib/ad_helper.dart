import 'dart:io';

class AdHelper {
  static get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544~3347511713';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544~3347511713';
    } else {
      throw UnsupportedError("Unsopperted Error");
    }
  }

  static get intrestitalAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544~3347511713';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544~3347511713';
    } else {
      throw UnsupportedError("Unsopperted PlatForm");
    }
  }
}
