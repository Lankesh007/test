import 'dart:convert';
import 'dart:developer';
import 'package:asb_news/models/news_by_select_district_model.dart';
import 'package:asb_news/models/select_district_model.dart';
import 'package:asb_news/models/select_state_model.dart';
import 'package:asb_news/models/state_news_model.dart';
import 'package:asb_news/models/uttarpradesh_details_model.dart';
import 'package:asb_news/screens/google_ads_screen.dart';
import 'package:asb_news/screens/samachar_screen.dart';
import 'package:asb_news/screens/uttar_pradesh_details.dart';
import 'package:asb_news/utils/api.dart';
import 'package:asb_news/utils/color.dart';
import 'package:asb_news/utils/globalFunction.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UttarPradeshScreen extends StatefulWidget {
  const UttarPradeshScreen({Key? key}) : super(key: key);
  @override
  _UttarPradeshScreenState createState() => _UttarPradeshScreenState();
}

class _UttarPradeshScreenState extends State<UttarPradeshScreen> {
  List<UttarPradeshDetailsModel> uttarPradeshList = [];
  List<SelectStateModel> stateCategory = [];
  List<SelectDistrictModel> districtCategory = [];
  List<StateNewsModel> stateNewsList = [];
  List<NewsBySelectDistrict> districtNewsList = [];

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
    _initFunction();

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

  // void initState() {
  //   WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
  //     _initFunction();
  //   });
  //   super.initState();
  // }

  _initFunction() async {
    getUttarPradeshDetails();
    getStateCategory();
    getDistrictCategory(stateId);
    getNewsBySelectDistrict(districtId);
  }

  var result;
  bool isState = true;
  bool isDistrict = true;
  double screenHeight = 0;
  double screenWidth = 0;
  String stateId = "";
  bool isSelectd = false;
  String districtId = "";
  int index = 0;
  var results;
  bool isData = true;
  var sId;
  var disId;
  bool selectState = false;

  @override
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
              controller: _scrollController,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: screenHeight / 18,
                  width: screenWidth,
                  color: themeColor,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // physics: NeverScrollableScrollPhysics(),
                    // reverse: false,
                    // shrinkWrap: true,
                    itemCount: stateCategory.length,
                    itemBuilder: (context, index) => stateNameWidget(
                      stateCategory[index],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                isState == false
                    ? Container(
                        height: screenHeight / 18,
                        width: screenWidth,
                        color: themeColor,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          // physics: NeverScrollableScrollPhysics(),
                          // reverse: false,
                          // shrinkWrap: true,
                          itemCount: districtCategory.length,
                          itemBuilder: (context, index) => districtNameWidget(
                            districtCategory[index],
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                results != null
                    ? Column(
                        children: [
                          isData == false
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 1.4,
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
                                )
                              : Text(
                                  "No Data Found",
                                  style: TextStyle(
                                    color: themeColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                        ],
                      )
                    : selectState == true
                        ? Container(
                            height: screenHeight / 1.4,
                            width: screenWidth,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              // physics: NeverScrollableScrollPhysics(),
                              // reverse: false,
                              // shrinkWrap: true,
                              itemCount: stateNewsList.length,
                              itemBuilder: (context, index) =>
                                  stateDetailsWidget(
                                stateNewsList[index],
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UttarPradeshDetailsScreen(
                                        id: uttarPradeshList[0].newsId,
                                        title: uttarPradeshList[0].newstitle,
                                        image: uttarPradeshList[0].newsImage,
                                        description:
                                            uttarPradeshList[0].newsContent,
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
                                          uttarPradeshList[0].newsImage,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        uttarPradeshList[0].newstitle,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          uttarPradeshList[0].newsTiming,
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
                                  scrollDirection: Axis.vertical,
                                  physics: NeverScrollableScrollPhysics(),
                                  reverse: false,
                                  shrinkWrap: true,
                                  itemCount: uttarPradeshList.length,
                                  itemBuilder: (context, index) =>
                                      newsDetailsWidget(
                                    uttarPradeshList[index],
                                  ),
                                ),
                              ),
                              bannerAdWidget()
                            ],
                          ),
              ],
            ),
    );
  }

  Widget newWidget(UttarPradeshDetailsModel item) {
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

  Widget newsDetailsWidget(UttarPradeshDetailsModel items) {
    return Column(
      children: [
        SizedBox(
          height: 0,
        ),
        items.newsId == 41071
            ? Container(
                height: 100,
              )
            : items.newsId == uttarPradeshList[index].newsId
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

  Widget stateNameWidget(SelectStateModel itemss) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            selectState = true;
            setState(() {
              sId = itemss.stateId;
              getSelectedStateNews(itemss.stateId);
            });
            getDistrictCategory(itemss.stateId);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              width: 2,
              color: sId == itemss.stateId ? Colors.white : themeColor,
            ))),
            child: Text(
              itemss.stateName,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget districtNameWidget(SelectDistrictModel itemsss) {
    districtId = itemsss.districtId;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              disId = itemsss.districtId;
            });
            getNewsBySelectDistrict(itemsss.districtId);

            // if (districtId == distId) {
            //   isSelectd = true;
            // }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                width: 2,
                color: disId == itemsss.districtId ? Colors.white : themeColor,
              )),
            ),
            child: Text(
              itemsss.districtName,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
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
                builder: (context) => SamacharScreen(
                  id: item.newsId,
                  title: item.newstitle,
                  image: item.newsImage,
                  description: item.newsContent,
                  imageUrl: item.imageUrl,
                ),
              ),
            );
            getNewsBySelectDistrict(item.newsId);
          },
          child: Card(
            child: Container(
              height: screenHeight / 7,
              width: screenWidth / 1.1,
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

  Widget stateDetailsWidget(StateNewsModel item) {
    return Column(
      children: [
        InkWell(
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
            getNewsBySelectDistrict(item.newsId);
          },
          child: Card(
            child: Container(
              height: screenHeight / 7,
              width: screenWidth / 1.1,
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

//---------------------------------API CALL------------------------------//
  Future getUttarPradeshDetails() async {
    var url = Settings.uttarpradershDetails;
    var res = await GlobalFunction.apiGetRequestae(url);
    result = jsonDecode(res);
    var _cryptoList = result as List;

    setState(() {
      uttarPradeshList.clear();
      var listdata =
          _cryptoList.map((e) => UttarPradeshDetailsModel.fromjson(e)).toList();
      uttarPradeshList.addAll(listdata);
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

  Future getStateCategory() async {
    var url = Settings.seelctStateCategory;
    var res = await GlobalFunction.apiGetRequestae(url);
    print(res);
    var result = jsonDecode(res);
    if (result["status"] == 1) {
      var _cryptoList = result['data'] as List;
      setState(() {
        stateCategory.clear();
        var listdata =
            _cryptoList.map((e) => SelectStateModel.fromjson(e)).toList();
        stateCategory.addAll(listdata);
      });
    }
  }

  Future getDistrictCategory(String stateId) async {
    var url = Settings.selectDistrictCategory + stateId + "&per_page=50";
    var res = await GlobalFunction.apiGetRequestae(url);

    var result = jsonDecode(res);
    var _cryptoList = result as List;
    setState(() {
      districtCategory.clear();
      var listdata =
          _cryptoList.map((e) => SelectDistrictModel.fromjson(e)).toList();
      districtCategory.addAll(listdata);
      // distId = districtCategory[index].districtId;

      // if (distId == districtId) {
      //   isSelectd = true;
      // }
      if (districtCategory.length > 0) {
        isState = false;
        // districtId = districtCategory.elementAt(0).districtId;
        // getNewsBySelectDistrict(districtId);
      }
    });
  }

  Future getNewsBySelectDistrict(districtId) async {
    var url = Settings.newsSelectByDistrict + districtId;
    var res = await GlobalFunction.apiGetRequestae(url);
    // print(res);
    results = jsonDecode(res);
    var _cryptoList = results as List;
    setState(() {
      districtNewsList.clear();
      var listdata =
          _cryptoList.map((e) => NewsBySelectDistrict.fromjson(e)).toList();
      districtNewsList.addAll(listdata);

      if (districtNewsList.length > 0) {
        isData = false;
      }
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
          _cryptoList.map((e) => UttarPradeshDetailsModel.fromjson(e)).toList();
      uttarPradeshList.addAll(listdata);
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
