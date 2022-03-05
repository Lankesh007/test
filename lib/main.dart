import 'package:asb_news/screens/google_ads_screen.dart';
import 'package:asb_news/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseMessaging.onBackgroundMessage(_messageHandler);
  AdMobService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
//
// Future<void> _messageHandler(RemoteMessage remoteMessage) async {
//   print("onBackgroundMessage-->"+remoteMessage.notification!.title.toString());
//
// }


/*
void _checkUpdate(BuildContext context) async {
    final newVersion = NewVersion(
      // iOSId: 'com.dekho.tv',
      androidId: 'com.dekho.tv',
    );

    final status = await newVersion.getVersionStatus();
    newVersion.showUpdateDialog(
        context: context,
        versionStatus: status!,
        dismissButtonText: 'Skip',
        updateButtonText: 'Update Now',
        dialogTitle: 'Update Available!',
        dialogText:
            'Please Update the app from ${status.localVersion} to ${status.storeVersion}',
        dismissAction: () {
          SystemNavigator.pop();
        });
    log('Version===> ${status.storeVersion}');
    log('Version1===> ${status.localVersion}');
    // You can let the plugin handle fetching the status and showing a dialog,
    // or you can fetch the status and display your own dialog, or no dialog.
  }
 */