import 'package:asb_news/models/select_district_model.dart';
import 'package:asb_news/screens/select_district_screen.dart';
import 'package:asb_news/screens/select_state_screen.dart';
import 'package:asb_news/utils/color.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SelectStateScreen(),
        ),
      );
    });

    super.initState();
  }
}
