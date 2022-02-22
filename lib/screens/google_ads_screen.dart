import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-4471645545827285/4161974544'
      : 'ca-app-pub-4711093547632141/6619437294';

  int num_attempot_load = 0;
  bool _isRewardedAdReady = false;

  static initialize() {
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  static BannerAd createBannerAds() {
    BannerAd ad = new BannerAd(
      size: AdSize.banner,
      adUnitId: bannerAdUnitId,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print('Ad Loaded'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad failed to load: $error');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => print('Ad closed.'),
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) => print('Ad impression.'),
      ),
    );
    return ad;
  }

  static BannerAd createBannerAd() {
    BannerAd ad = new BannerAd(
      size: AdSize.mediumRectangle,
      adUnitId: bannerAdUnitId,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print('Ad Loaded'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad failed to load: $error');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => print('Ad closed.'),
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) => print('Ad impression.'),
      ),
    );
    return ad;
  }
}
