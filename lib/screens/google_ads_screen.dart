import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-4471645545827285/4161974544'
      : 'ca-app-pub-4711093547632141/6619437294';
  static String get rewardAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-4471645545827285/4224719573'
      : 'ca-app-pub-4711093547632141/9549154282';
  static String get interstitialAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-4471645545827285/4189894704'
      : 'ca-app-pub-4711093547632141/7765492848';

  int num_attempot_load = 0;
  bool _isRewardedAdReady = false;
  late RewardedAd _rewardedAd;
  late InterstitialAd _interstitialAd;

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

  void createInterAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          num_attempot_load = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          num_attempot_load + 1;
          _interstitialAd = _interstitialAd;
          if (num_attempot_load <= 2) {
            createInterAd();
          }
        },
      ),
    );
  }

  void showInterAd() {
    if (_interstitialAd == null) {
      return;
    }
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {
      print('Ad onShowAd Fullscreen');
    }, onAdDismissedFullScreenContent: (InterstitialAd ad) {
      print('Ad Dismissed');
      ad.dispose();
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      print('$ad OnAdError $error');
      ad.dispose();
    });
    _interstitialAd.show();
    _interstitialAd = _interstitialAd;
  }
  //   void showRewardedAd() {
  //   _rewardedAd.show(
  //     onUserEarnedReward: (RewardedAd ad, RewardItem rpoint) {
  //       print('Rewarded Earned is ${rpoint.amount}');
  //     },
  //   );
  //   _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
  //     onAdShowedFullScreenContent: (RewardedAd ad) {},
  //     onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
  //       print('Ad error');
  //       // ad.dispose();
  //     },
  //     onAdDismissedFullScreenContent: (RewardedAd ad) {
  //       print('Ad Dismissed');
  //       // ad.dispose();
  //     },
  //   );
  // }

}
