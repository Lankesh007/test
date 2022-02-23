import 'package:asb_news/screens/homepage_screen.dart';
import 'package:asb_news/screens/select_state_screen.dart';
import 'package:asb_news/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? _preferences;
  List<String> idList = [];
  List<String> nameList = [];
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
    saveData();

    super.initState();
  }

  Future saveData() async {
    _preferences = await SharedPreferences.getInstance();
    String isInit = "";
    setState(() {
      if (idList.length > 0) {
        isInit = _preferences!.getString('isInit').toString();
        idList = _preferences!.getStringList('idDistrict')!.toList();
        nameList = _preferences!.getStringList('namedistrict')!.toList();
      }
    });
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (isInit != "") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePageScreen(
                districtId: idList.toString(),
                districtName: nameList.toString(),
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
      },
    );
  }
}
