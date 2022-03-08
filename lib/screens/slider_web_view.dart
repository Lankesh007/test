import 'package:asb_news/screens/google_ads_screen.dart';
import 'package:asb_news/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SliderWebViewScreen extends StatefulWidget {
  final String url;
  const SliderWebViewScreen({required this.url, Key? key}) : super(key: key);

  @override
  State<SliderWebViewScreen> createState() => _SliderWebViewScreenState();
}

class _SliderWebViewScreenState extends State<SliderWebViewScreen> {
  double screenWidth = 0;
  double screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: const Text(
          'Sliders News',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: widget.url == ""
          ? islodaing
          : WebView(
              initialUrl: "${widget.url}",
            ),
    );
  }

  Widget bannerAdWidget() {
    return Container(
      child: AdWidget(
        ad: AdMobService.createBannerAd()..load(),
        key: UniqueKey(),
      ),
      width: screenWidth,
      height: 270.0,
      alignment: Alignment.center,
    );
  }
}
