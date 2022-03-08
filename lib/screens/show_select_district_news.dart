import 'dart:convert';
import 'dart:developer';

import 'package:asb_news/models/news_by_select_district_model.dart';
import 'package:asb_news/screens/google_ads_screen.dart';
import 'package:asb_news/screens/samachar_screen.dart';
import 'package:asb_news/utils/api.dart';
import 'package:asb_news/utils/color.dart';
import 'package:asb_news/utils/globalFunction.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowSelectedNewsDistrict extends StatefulWidget {
  final title;
  final id;

  const ShowSelectedNewsDistrict(
      {required this.title, required this.id, Key? key})
      : super(key: key);

  @override
  State<ShowSelectedNewsDistrict> createState() =>
      _ShowSelectedNewsDistrictState();
}

class _ShowSelectedNewsDistrictState extends State<ShowSelectedNewsDistrict> {
  // void initState() {
  //   WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
  //     _initFunction();
  //   });
  // }

  // }

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  FocusNode searchFocus = FocusNode();
  late SharedPreferences _preferences;
  bool isSearch = false;
  bool isSearchTap = false;
  bool isProduct = false;
  bool isSubscribePro = false;
  bool isLogin = false;
  bool _hasNext = true;
  bool isLoadMore = false;
  bool isLoadfirst = false;
  ScrollController _scrollController = ScrollController();
  String userId = '';
  int page = 1;

  @override
  void initState() {
    getNewsBySelectDistrict(widget.id, widget.title);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      initPref();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          page++;
          _hasNext = true;
          isLoadMore = true;
        });
        getScrollingDetails(page.toString());
      } /*  else if (_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent) {
        setState(() {
          if (page > 0) {
            page--;
            isLoadfirst = true;
            getScrollingDetails(page.toString());
          }
        });
      } */
      // log('=================>>>' + page.toString());
    });

    super.initState();
    // initPref();
  }

  double screenHeight = 0;
  double screenWidth = 0;
  List<NewsBySelectDistrict> districtNewsList = [];
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        controller: _scrollController,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              Container(
                height: screenHeight / 3,
                child: Column(
                  children: [
                    SizedBox(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SamacharScreen(
                              id: districtNewsList[0].newsId,
                              title: districtNewsList[0].newstitle,
                              image: districtNewsList[0].newsImage,
                              description: districtNewsList[0].newsContent,
                              imageUrl: districtNewsList[0].imageUrl,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: screenHeight / 4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(districtNewsList[0].newsImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Text(
                        districtNewsList[0].newstitle,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bannerAdWidget(),
          Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: districtNewsList.length,
              itemBuilder: (context, index) => newsDetailsWidget(
                districtNewsList[index],
              ),
            ),
          ),
          bannerAdWidget(),
        ],
      ),
    );
  }

  Widget slectedNewsWidget() {
    return Column(
      // controller: _scrollController,
      // shrinkWrap: true,
      // physics: BouncingScrollPhysics(),
      children: [
        InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => SamacharScreen(
            //       id: khelDetailsList[0].newsId,
            //       title: khelDetailsList[0].newstitle,
            //       image: khelDetailsList[0].newsImage,
            //       description: khelDetailsList[0].newsContent,
            //       imageUrl: khelDetailsList[0].imageUrl,
            //     ),
            //   ),
            // );
          },
          child: Container(
            height: screenHeight / 2.7,
            child: Card(
                child: Column(
              children: [
                Container(
                  child: Image.network(
                    " khelDetailsList[0].newsImage,",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "khelDetailsList[0].newstitle,",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "khelDetailsList[0].newsTiming,",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            )),
          ),
        ),
        bannerAdWidget(),
        // Container(
        //   child: ListView.builder(
        //     scrollDirection: Axis.vertical,
        //     physics: NeverScrollableScrollPhysics(),
        //     reverse: false,
        //     shrinkWrap: true,
        //     itemCount: khelDetailsList.length,
        //     itemBuilder: (context, index) => newsDetailsWidget(
        //       khelDetailsList[index],
        //     ),
        //   ),
        // ),
      ],
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

  Widget newsDetailsWidget(NewsBySelectDistrict item) {
    return Column(
      children: [
        SizedBox(
          height: 0,
        ),
        // items.newsId == 41071
        // ?
        // Container(
        //     height: 100,
        //   )
        // // : items.newsId == techList[0].newsId
        //     ? Container()
        //     :
        item.newsId == districtNewsList[0].newsId
            ? Container()
            : InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SamacharScreen(
                        id: item.newsId,
                        title: item.newstitle,
                        image: item.newsImage,
                        description: item.newsContent,
                        imageUrl: item.imageUrl,
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
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5)),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      item.newsImage,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                height: screenHeight / 8,
                                width: screenWidth / 1.7,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Text(
                                        item.newstitle,
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
                                        // bottom: 10,
                                      ),
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        item.newsTiming,
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

  //----------------------API CALL---------------

  Future getNewsBySelectDistrict(id, title) async {
    var url = Settings.newsSelectByDistrict + id;
    log('====>   $url');
    var res = await GlobalFunction.apiGetRequestae(url);
    // print(res);
    var results = jsonDecode(res);
    var _cryptoList = results as List;
    setState(() {
      districtNewsList.clear();
      var listdata =
          _cryptoList.map((e) => NewsBySelectDistrict.fromjson(e)).toList();
      districtNewsList.addAll(listdata);
    });
  }

  Future getScrollingDetails(page) async {
    var url = Settings.scrollingData + page;
    var res = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(res);

    var _cryptoList = result as List;
    setState(() {
      // deshDetailsList.clear();
      var listdata =
          _cryptoList.map((e) => NewsBySelectDistrict.fromjson(e)).toList();
      districtNewsList.addAll(listdata);
    });
  }

  initPref() async {
    _preferences = await SharedPreferences.getInstance();

    log(userId);

    // getScrollingDetails(page.toString());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
