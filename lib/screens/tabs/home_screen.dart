import 'dart:convert';
import 'package:asb_news/models/default_news_model.dart';
import 'package:asb_news/models/news_by_select_district_model.dart';
import 'package:asb_news/screens/news_details_screen.dart';
import 'package:asb_news/screens/details_by_slected_district.dart';
import 'package:asb_news/utils/api.dart';
import 'package:asb_news/utils/color.dart';
import 'package:asb_news/utils/globalFunction.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final districtId;
  final districtName;
  const HomeScreen(
      {required this.districtId, required this.districtName, Key? key})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DefaultNewsModel> defaultNews = [];

  Future getDefaultNewss() async {
    var url = Settings.defaultNews;
    var res = await GlobalFunction.apiGetRequestae(url);
    // print(res);
    var result = jsonDecode(res);
    var _cryptoList = result as List;
    setState(() {
      defaultNews.clear();
      var listdata =
          _cryptoList.map((e) => DefaultNewsModel.fromjson(e)).toList();
      defaultNews.addAll(listdata);
    });
  }

  List<NewsBySelectDistrict> districtNewsList = [];
  var result;
  Future getNewsBySelectDistrict() async {
    var url = Settings.newsSelectByDistrict + widget.districtId;
    var res = await GlobalFunction.apiGetRequestae(url);
    // print(res);
    result = jsonDecode(res);
    var _cryptoList = result as List;
    setState(() {
      districtNewsList.clear();
      var listdata =
          _cryptoList.map((e) => NewsBySelectDistrict.fromjson(e)).toList();
      districtNewsList.addAll(listdata);
    });
  }

  void initState() {
    getDefaultNewss();
    getNewsBySelectDistrict();
    super.initState();
  }

  double screenHeight = 0;
  double screenWidth = 0;

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
                        height: MediaQuery.of(context).size.height / 1.48,
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
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
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
                        )),
                  ],
                ),
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
}
