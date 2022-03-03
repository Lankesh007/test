import 'package:asb_news/screens/google_ads_screen.dart';
import 'package:asb_news/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class PopularNewsScreen extends StatefulWidget {
  final id;
  final title;
  final image;
  final description;
  const PopularNewsScreen(
      {required this.id,
      required this.title,
      required this.image,
      required this.description,
      Key? key})
      : super(key: key);

  @override
  _PopularNewsScreenState createState() => _PopularNewsScreenState();
}

class _PopularNewsScreenState extends State<PopularNewsScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(
          "Popular News",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => DhamakedarNewsScreen()));
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        centerTitle: true,
      ),
      body: widget.id == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: islodaing,
                ),
              ],
            )
          : ListView(
              children: [
                Column(
                  children: [
                    newsHeadlineWidget(),
                    Container(
                      height: screenHeight / 4,
                      width: screenWidth / 1.05,
                      child: Image.network(
                        widget.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Html(
                      data: widget.description,
                    ),
                    bannerAdWidget(),
                    bannerAdWidget(),
                  ],
                ),
              ],
            ),
    );
  }

  Widget newsHeadlineWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Text(
        widget.title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
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
