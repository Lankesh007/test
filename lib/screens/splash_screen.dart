import 'dart:developer';

import 'package:asb_news/screens/homepage_screen.dart';
import 'package:asb_news/screens/select_state_screen.dart';
import 'package:asb_news/utils/color.dart';
import 'package:asb_news/utils/constantKey.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? _preferences;
  List<String?> idList = [];
  List<String?> titleList = [];
  bool isInit = false;
  String? token = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset("assets/asbnews-header.png"),
            ),
            CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 5,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initPref();
  }

  Future _initPref() async {
    token = await FirebaseMessaging.instance.getToken();
    log('Token==>  $token');

    _preferences = await SharedPreferences.getInstance();
    isInit = (_preferences!.getBool('$selected') == true) ? true : false;
    if (isInit == true) {
      idList = _preferences!.getStringList('$distIdList')!;
      titleList = _preferences!.getStringList('$distTitleList')!;
      log('message==>  ${_preferences!.getBool('$selected')}');
      log('message==>  ${_preferences!.getStringList('$distIdList')}');
      log('message==>  ${_preferences!.getStringList('$distTitleList')}');
    }
    Future.delayed(const Duration(seconds: 3), () {
      if (isInit == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePageScreen(
              districtIdList: idList,
              districtNameList: titleList,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectStateScreen(),
          ),
        );
      }
    });
  }
}
