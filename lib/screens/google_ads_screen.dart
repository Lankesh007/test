// import 'package:asb_news/ad_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class GoogleAdsScreen extends StatefulWidget {
//   const GoogleAdsScreen({Key? key}) : super(key: key);

//   @override
//   _GoogleAdsScreenState createState() => _GoogleAdsScreenState();
// }

// class _GoogleAdsScreenState extends State<GoogleAdsScreen> {
//   late BannerAd _bannerAd;
//   bool _isBannerAdReady = false;

//   void initState() {
//     _bannerAd = BannerAd(
//         size: AdSize.banner,
//         adUnitId: AdHelper.bannerAdUnitId,
//         listener: BannerAdListener(onAdLoaded: (_) {
//           setState(
//             () {
//               _isBannerAdReady = true;
//             },
//           );
//         }, onAdFailedToLoad: (ad, error) {
//           print("Failed to  load banner Ads{error.message}");
//           _isBannerAdReady = false;
//           ad.dispose();
//         }),
//         request: AdRequest())
//       ..load();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

import 'dart:developer';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-2290657017957469/7979638199'
      : 'ca-app-pub-2290657017957469/7979638199';

  static initialize() {
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  static BannerAd createBannerAd() {
    BannerAd ad = BannerAd(
        size: AdSize.mediumRectangle,
        adUnitId: bannerAdUnitId,
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) => log('Ad loaded'),
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
          },
          onAdOpened: (Ad ad) => log("Ad Opend"),
          onAdClosed: (Ad ad) => log("Ad Closed"),
        ),
        request: AdRequest());
    return ad;
  }
}
