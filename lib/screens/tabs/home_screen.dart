import 'dart:convert';
import 'dart:developer';
import 'package:asb_news/models/default_news_model.dart';
import 'package:asb_news/models/news_by_select_district_model.dart';
import 'package:asb_news/models/popularNewsModel.dart';
import 'package:asb_news/models/releated_news_model.dart';
import 'package:asb_news/models/slider_model.dart';
import 'package:asb_news/models/state_news_model.dart';
import 'package:asb_news/models/userNewsList.dart';
import 'package:asb_news/screens/google_ads_screen.dart';
import 'package:asb_news/screens/samachar_screen.dart';
import 'package:asb_news/screens/show_select_district_news.dart';
import 'package:asb_news/screens/slider_web_view.dart';
import 'package:asb_news/utils/api.dart';
import 'package:asb_news/utils/color.dart';
import 'package:asb_news/utils/constantKey.dart';
import 'package:asb_news/utils/globalFunction.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  final List districtIdList;
  final List districtNameList;

  const HomeScreen({
    required this.districtIdList,
    required this.districtNameList,
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  var result;
  List<DefaultNewsModel> defaultNews = [];
  List<UserNewsModel> userNewsList = [];
  List<RelatedNewsModel> relatedNewsList = [];
  List<PopularNewsModel> popularNewsList = [];
  List<SliderDataModel> sliderDataList = [];
  List<StateNewsModel> stateNewsList = [];
  SharedPreferences? _preferences;

  List<NewsBySelectDistrict> districtNewsList = [];
  var results;

  String id = '';
  String name = '';
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _initFunction();
    });
  }

  _initFunction() async {
    getDefaultNewss();
    // getNewsBySelectDistrict();
    getPopularNewsDetails();
    getRelatedNewsDetails();
    getUserNews();
    getsliderDetails();
    getUserDeatils();
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
          : Container(
              height: screenHeight,
              child: ListView(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: screenHeight / 6,
                    width: screenWidth,
                    child: CarouselSlider.builder(
                      itemCount: sliderDataList.length,
                      options: CarouselOptions(
                        height: screenHeight / 4,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        reverse: false,
                      ),
                      itemBuilder: (context, i, id) {
                        return GestureDetector(
                          onTap: () {
                            var url = sliderDataList[i].sliderUrl;
                            log("url====>" + url);
                            // launch(url);
                            // log("====>" + url);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SliderWebViewScreen(
                                  url: url,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: screenHeight / 6,
                            width: screenWidth,
                            child: Image.network(
                              sliderDataList[i].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

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
                            shrinkWrap: true,
                            itemCount: defaultNews.length,
                            itemBuilder: (context, index) => newsDetailsWidget(
                              defaultNews[index],
                            ),
                          ),
                        ),
                      ),
                      bannerAdWidget(),
                    ],
                  ),
                  stateNameWidget(),
                  Column(
                    children: [
                      Container(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 1.45,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: stateNewsList.length,
                            itemBuilder: (context, index) => slectStateWidget(
                              stateNewsList[index],
                            ),
                          ),
                        ),
                      ),
                      bannerAdWidget(),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: userNewsList.length,
                      itemBuilder: (context, index) {
                        var item = userNewsList[index];
                        return (item.districtNewsList.length > 0)
                            ? Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        height: screenHeight / 18,
                                        color: themeColor,
                                        width: screenWidth,
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Text(
                                            item.title,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  selectedNewsDetailsWidget(index),
                                  orDekheWidget(item.id, item.title),
                                  bannerAdWidget(),
                                ],
                              )
                            : Container();
                      },
                    ),
                  ),
                  // bannerAdWidget(),
                ],
              ),
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
                  "ब्रेकिंग न्यूज",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
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
                builder: (context) => SamacharScreen(
                  id: items.newsId,
                  title: items.newstitle,
                  image: items.newsImage,
                  description: items.newsContent,
                  imageUrl: items.imageUrl,
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
                                    fontSize: 16,
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

  Widget orDekheWidget(String id, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowSelectedNewsDistrict(
                          id: id,
                          title: title,
                        )));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Text(
              "और देखें",
              style: TextStyle(
                color: themeColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget selectedNewsDetailsWidget(int index) {
    var itemList = userNewsList[index].districtNewsList;
    return Container(
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SamacharScreen(
                      id: itemList[index].newsId,
                      title: itemList[index].newstitle,
                      image: itemList[index].newsImage,
                      description: itemList[index].newsDiscription,
                      imageUrl: itemList[index].imageUrl,
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
                              width: screenWidth / 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    itemList[index].newsImage,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              width: screenWidth / 1.7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    child: Text(
                                      itemList[index].newstitle,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      top: 5,
                                      right: 5,
                                    ),
                                    child: Text(
                                      itemList[index].newsTiming,
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
            );
          }),
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

  Widget stateNameWidget() {
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
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget slectStateWidget(StateNewsModel items) {
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
                builder: (context) => SamacharScreen(
                  id: items.newsId,
                  title: items.newstitle,
                  image: items.newsImage,
                  description: items.newsContent,
                  imageUrl: items.imageUrl,
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
                                    fontSize: 16,
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

  Future getSelectedStateNews(String sId) async {
    var url = Settings.selectStateNews + sId.toString();
    var res = await GlobalFunction.apiGetRequestae(url);
    result = jsonDecode(res);
    var _cryptoList = result as List;
    setState(() {
      stateNewsList.clear();
      var listdata =
          _cryptoList.map((e) => StateNewsModel.fromjson(e)).toList();
      stateNewsList.addAll(listdata);
    });
  }

  Future getUserDeatils() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      id = _preferences!.getString(stateId).toString();
      name = _preferences!.getString(stateName).toString();
    });
    getSelectedStateNews(id);

    log("======>" + id + name);
  }

  Future getNewsBySelectDistrict(id, title) async {
    var url = Settings.newsSelectByDistrict + id;
    log('====>   $url');
    var res = await GlobalFunction.apiGetRequestae(url);
    // print(res);
    results = jsonDecode(res);
    var _cryptoList = results as List;
    setState(() {
      districtNewsList.clear();
      var listdata =
          _cryptoList.map((e) => NewsBySelectDistrict.fromjson(e)).toList();

      // userNewsList.add(id, title, districtNewsList);
      // districtNewsList.addAll(listdata);
      // log(districtNewsList.elementAt(0).newstitle);

      userNewsList
          .add(UserNewsModel(id: id, title: title, districtNewsList: listdata));
    });
  }

  Future getUserNews() async {
    for (int i = 0; i < widget.districtIdList.length; i++) {
      String id = '';
      String title = '';
      setState(() {
        id = widget.districtIdList[i];
        title = widget.districtNameList[i];
      });
      getNewsBySelectDistrict(id, title);
    }
  }

  Future getRelatedNewsDetails() async {
    var url = Settings.relatedNews;
    var res = await GlobalFunction.apiGetRequestae(url);
    result = jsonDecode(res);

    var _cryptoList = result as List;
    setState(() {
      relatedNewsList.clear();
      var listdata =
          _cryptoList.map((e) => RelatedNewsModel.fromjson(e)).toList();
      relatedNewsList.addAll(listdata);
    });
  }

  Future getPopularNewsDetails() async {
    var url = Settings.popularNews;
    var res = await GlobalFunction.apiGetRequestae(url);
    result = jsonDecode(res);

    var _cryptoList = result as List;
    setState(() {
      popularNewsList.clear();
      var listdata =
          _cryptoList.map((e) => PopularNewsModel.fromjson(e)).toList();
      popularNewsList.addAll(listdata);
    });
  }

  Future getsliderDetails() async {
    var url = Settings.sliderDetails;
    var res = await GlobalFunction.apiGetRequestae(url);
    result = jsonDecode(res);

    var _cryptoList = result["details"] as List;
    setState(() {
      if (result["status"] == 1) {
        sliderDataList.clear();
        var listdata =
            _cryptoList.map((e) => SliderDataModel.fromjson(e)).toList();
        sliderDataList.addAll(listdata);
      }
    });
  }
}
