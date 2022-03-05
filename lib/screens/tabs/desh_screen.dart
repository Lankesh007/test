import 'dart:convert';
import 'dart:developer';
import 'package:asb_news/models/desh_deatils_model.dart';
import 'package:asb_news/screens/google_ads_screen.dart';
import 'package:asb_news/screens/samachar_screen.dart';
import 'package:asb_news/utils/api.dart';
import 'package:asb_news/utils/color.dart';
import 'package:asb_news/utils/globalFunction.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeshScreen extends StatefulWidget {
  const DeshScreen({Key? key}) : super(key: key);

  @override
  _DeshScreenState createState() => _DeshScreenState();
}

class _DeshScreenState extends State<DeshScreen> {
  List<DeshDetailsModel> deshDetailsList = [];

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
    getDeshDetails();

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
      log('=================>>>' + page.toString());
    });

    super.initState();
    // initPref();
  }

  var result;

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
          : Container(
              height: screenHeight,
              child: ListView(
                controller: _scrollController,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SamacharScreen(
                            id: deshDetailsList[0].newsId,
                            title: deshDetailsList[0].newstitle,
                            image: deshDetailsList[0].newsImage,
                            description: deshDetailsList[0].newsContent,
                            imageUrl: deshDetailsList[0].imageUrl,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: screenHeight / 2.7,
                      child: Card(
                          child: Column(
                        children: [
                          Container(
                            child: Image.network(
                              deshDetailsList[0].newsImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            deshDetailsList[0].newstitle,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              deshDetailsList[0].newsTiming,
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
                  Container(
                    child: ListView.builder(
                      // controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      reverse: false,
                      itemCount: deshDetailsList.length,
                      itemBuilder: (context, index) => newsDetailsWidget(
                        deshDetailsList[index],
                      ),
                    ),
                  ),
                  bannerAdWidget()
                ],
              ),
            ),
    );
  }

  Widget newWidget(DeshDetailsModel item) {
    return Container(
      child: Text(item.newsId),
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

  Widget newsDetailsWidget(DeshDetailsModel items) {
    return Column(
      children: [
        SizedBox(
          height: 0,
        ),
        items.newsId == 41071
            ? Container(
                height: 100,
              )
            : items.newsId == deshDetailsList[0].newsId
                ? Container()
                : InkWell(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: screenHeight / 10,
                                    width: screenWidth / 3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5)),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                            top: 10,
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
                                            // bottom: 10,
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

  //--------------------API Call

  Future getDeshDetails() async {
    var url = Settings.deshDetails;
    var res = await GlobalFunction.apiGetRequestae(url);
    result = jsonDecode(res);

    var _cryptoList = result as List;
    setState(() {
      deshDetailsList.clear();
      var listdata =
          _cryptoList.map((e) => DeshDetailsModel.fromjson(e)).toList();
      deshDetailsList.addAll(listdata);
    });
  }

  Future getScrollingDetails(page) async {
    var url = Settings.scrollingData + page;
    var res = await GlobalFunction.apiGetRequestae(url);
    result = jsonDecode(res);

    var _cryptoList = result as List;
    setState(() {
      // deshDetailsList.clear();
      var listdata =
          _cryptoList.map((e) => DeshDetailsModel.fromjson(e)).toList();
      deshDetailsList.addAll(listdata);
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
