import 'dart:convert';
import 'package:asb_news/models/default_news_model.dart';
import 'package:asb_news/models/news_by_select_district_model.dart';
import 'package:asb_news/screens/google_ads_screen.dart';
import 'package:asb_news/screens/news_details_screen.dart';
import 'package:asb_news/screens/details_by_slected_district.dart';
import 'package:asb_news/utils/api.dart';
import 'package:asb_news/utils/color.dart';
import 'package:asb_news/utils/globalFunction.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final String districtId;
  final String districtName;
  const HomeScreen({
    required this.districtId,
    required this.districtName,
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  var result;
  var _prefences;
  List<DefaultNewsModel> defaultNews = [];

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _initFunction();
    });
  }

  _initFunction() async {
    getDefaultNewss();
    getNewsBySelectDistrict();
    _prefences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: result == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: islodaing,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Loading.....",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            )
          : ListView(
              children: [
                topBannerWidget(),
                Column(
                  children: [
                    Container(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 1.45,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          reverse: false,
                          shrinkWrap: true,
                          itemCount: defaultNews.length,
                          itemBuilder: (context, index) => newsDetailsWidget(
                            defaultNews[index],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: screenHeight / 2,
                      width: screenWidth / 1.04,
                      child: Card(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: themeColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                      )),
                                  alignment: Alignment.center,
                                  height: screenHeight / 25,
                                  width: screenWidth / 5,
                                  child: Text(
                                    widget.districtName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  child: Divider(
                                    color: themeColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 2.5,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                // physics: NeverScrollableScrollPhysics(),
                                // reverse: false,
                                // shrinkWrap: true,
                                itemCount: districtNewsList.length,
                                itemBuilder: (context, index) =>
                                    selectedNewsDetailsWidget(
                                  districtNewsList[index],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                bannerAdWidget(),
                Container(
                  height: screenHeight / 3,
                  width: screenWidth / 1.01,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: screenHeight / 22,
                          width: screenWidth / 4,
                          decoration: BoxDecoration(
                            color: themeColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                5,
                              ),
                            ),
                          ),
                          child: Text(
                            "Related News",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        relatedNewsWidget(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                bannerAdWidget(),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Container(
                    alignment: Alignment.center,
                    height: screenHeight / 22,
                    width: screenWidth / 4,
                    decoration: BoxDecoration(
                      color: themeColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          5,
                        ),
                      ),
                    ),
                    child: Text(
                      "Popular News",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                popularNewsWidget(),
                bannerAdWidget(),
              ],
            ),
    );
  }

  Widget topBannerWidget() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: screenHeight / 20,
                width: screenWidth / 1.1,
                decoration: BoxDecoration(
                  color: themeColor,
                ),
                child: Text(
                  "राष्ट्रीय समाचार",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget newsDetailsWidget(DefaultNewsModel items) {
    return Column(
      children: [
        SizedBox(
          height: 0,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsDetaailsScreen(
                  id: items.newsId,
                  title: items.newstitle,
                  image: items.newsImage,
                  description: items.newsContent,
                ),
              ),
            );
          },
          child: Card(
            child: Container(
              height: screenHeight / 7.6,
              width: screenWidth / 1.05,
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: screenHeight / 10,
                          width: screenWidth / 3,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(5)),
                            image: DecorationImage(
                              image: NetworkImage(
                                items.newsImage,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: screenHeight / 8,
                          width: screenWidth / 1.7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    // top: 10,
                                    ),
                                child: Text(
                                  items.newstitle,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  right: 10,
                                  bottom: 10,
                                ),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  items.newsTiming,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget selectedNewsDetailsWidget(NewsBySelectDistrict item) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SlectNewsByDistrict(
                  id: item.newsId,
                  title: item.newstitle,
                  image: item.newsImage,
                  description: item.newsContent,
                ),
              ),
            );
          },
          child: Card(
            child: Container(
              height: screenHeight / 7,
              width: screenWidth / 1.2,
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: screenHeight / 10,
                          width: screenWidth / 3.6,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(5)),
                            image: DecorationImage(
                              image: NetworkImage(
                                item.newsImage,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                child: Text(
                                  item.newstitle,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 4,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 5,
                                  right: 5,
                                ),
                                child: Text(
                                  item.newsTiming,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget relatedNewsWidget() {
    return Container(
      height: screenHeight / 4.5,
      width: screenWidth / 2.5,
      child: Card(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      5,
                    ),
                    topRight: Radius.circular(
                      5,
                    ),
                  ),
                  image: DecorationImage(
                      image: NetworkImage(
                        "https://www.youandthemat.com/wp-content/uploads/nature-2-26-17.jpg",
                      ),
                      fit: BoxFit.cover)),
              height: screenHeight / 9,
              width: screenWidth,
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Text(
                "If the [style] argument is null, the text will use the style from the closest enclosing [DefaultTextStyle]",
                style: TextStyle(
                  fontSize: 12,
                ),
                maxLines: 3,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Text(
                "7 hours ago",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ],
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

  Widget popularNewsWidget() {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => NewsDetaailsScreen(
        //       id: items.newsId,
        //       title: items.newstitle,
        //       image: items.newsImage,
        //       description: items.newsContent,
        //     ),
        //   ),
        // );
      },
      child: Card(
        child: Container(
          height: screenHeight / 7,
          width: screenWidth / 1.05,
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: screenHeight / 10,
                      width: screenWidth / 3,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(5)),
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://media.cntraveler.com/photos/60596b398f4452dac88c59f8/16:9/w_3999,h_2249,c_limit/MtFuji-GettyImages-959111140.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: screenHeight / 8,
                      width: screenWidth / 1.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: Text(
                              "items.newstitle",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 3,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              right: 10,
                              bottom: 10,
                            ),
                            alignment: Alignment.centerRight,
                            child: Text(
                              "items.newsTiming",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//-----------------------------------------------------------Api Call
  Future getDefaultNewss() async {
    var url = Settings.defaultNews;
    var res = await GlobalFunction.apiGetRequestae(url);
    result = jsonDecode(res);
    var _cryptoList = result as List;
    setState(() {
      defaultNews.clear();
      var listdata =
          _cryptoList.map((e) => DefaultNewsModel.fromjson(e)).toList();
      defaultNews.addAll(listdata);
    });
  }

  List<NewsBySelectDistrict> districtNewsList = [];
  var results;
  Future getNewsBySelectDistrict() async {
    var url = Settings.newsSelectByDistrict +
        widget.districtId.toString().replaceAll('[', '').replaceAll(']', '');

    var res = await GlobalFunction.apiGetRequestae(url);
    // print(res);
    results = jsonDecode(res);
    var _cryptoList = results as List;
    setState(() {
      districtNewsList.clear();
      var listdata =
          _cryptoList.map((e) => NewsBySelectDistrict.fromjson(e)).toList();
      districtNewsList.addAll(listdata);
    });
  }
}
