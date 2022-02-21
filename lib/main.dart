import 'package:asb_news/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ASB News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // _bannerAd = BannerAd(
    //     size: AdSize.banner,
    //     adUnitId: AdHelper.bannerAdUnitId,
    //     listener: BannerAdListener(onAdLoaded: (_) {
    //       setState(
    //         () {
    //           _isBannerAdReady = true;
    //         },
    //       );
    //     }, onAdFailedToLoad: (ad, error) {
    //       print("Failed to  load banner Ads{error.message}");
    //       _isBannerAdReady = false;
    //       ad.dispose();
    //     }),
    //     request: AdRequest())
    //   ..load();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
      );
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold();
  }
}
