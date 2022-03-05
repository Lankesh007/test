import 'dart:convert';

import 'package:asb_news/models/adhyatmic_details_model.dart';
import 'package:asb_news/models/garam_masala_model.dart';
import 'package:asb_news/models/healthy_details_model.dart';
import 'package:asb_news/models/technology_details_model.dart';
import 'package:asb_news/models/vyapar_details_model.dart';
import 'package:asb_news/screens/google_ads_screen.dart';
import 'package:asb_news/screens/homepage_screen.dart';
import 'package:asb_news/screens/samachar_screen.dart';
import 'package:asb_news/utils/api.dart';
import 'package:asb_news/utils/color.dart';
import 'package:asb_news/utils/constantKey.dart';
import 'package:asb_news/utils/globalFunction.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DhamakedarNewsScreen extends StatefulWidget {
  const DhamakedarNewsScreen({Key? key}) : super(key: key);

  @override
  _DhamakedarNewsScreenState createState() => _DhamakedarNewsScreenState();
}

class _DhamakedarNewsScreenState extends State<DhamakedarNewsScreen> {
  void initState() {
    getGaramMasalaNews();
    gettechnologyNews();
    getHealthNews();
    getbusinessNews();
    getadhyatmDetailsNews();
    saveData();
    super.initState();
  }

  SharedPreferences? _preferences;

  saveData() async {
    _preferences = await SharedPreferences.getInstance();

    idList = _preferences!.getStringList('$distIdList')!;
    titleList = _preferences!.getStringList('$distTitleList')!;
  }

  List<GaramMasalaModel> garamMaslaList = [];
  List<TechnologyDetailsModel> techList = [];
  List<HealthyDetailsModel> healthyList = [];
  List<VyaparDetailsModel> vyaparDetailsList = [];
  List<AdhyatmicDetailsModel> adhyatmicDetailsList = [];
  List<String?> idList = [];
  List<String?> titleList = [];
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
          "Top News",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePageScreen(
                      districtIdList: idList, districtNameList: titleList),
                ),
              );
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // topMargin,
              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                alignment: Alignment.center,
                height: screenHeight / 22,
                width: screenWidth / 3,
                child: Text(
                  "गरम मसाला ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      15,
                    ),
                  ),
                ),
              ),
              Container(
                height: screenHeight / 1.45,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  reverse: false,
                  shrinkWrap: true,
                  itemCount: garamMaslaList.length,
                  itemBuilder: (context, index) => newsCardWidget(
                    garamMaslaList[index],
                  ),
                ),
              ),
              bannerAdWidget(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                alignment: Alignment.center,
                height: screenHeight / 22,
                width: screenWidth / 3,
                child: Text(
                  "टेक्नोलॉजी",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      15,
                    ),
                  ),
                ),
              ),
              Container(
                height: screenHeight / 1.45,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  reverse: false,
                  shrinkWrap: true,
                  itemCount: techList.length,
                  itemBuilder: (context, index) => technologyWidget(
                    techList[index],
                  ),
                ),
              ),
              bannerAdWidget(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                alignment: Alignment.center,
                height: screenHeight / 22,
                width: screenWidth / 3,
                child: Text(
                  "हेल्थ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      15,
                    ),
                  ),
                ),
              ),
              Container(
                height: screenHeight / 1.45,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  reverse: false,
                  shrinkWrap: true,
                  itemCount: healthyList.length,
                  itemBuilder: (context, index) => healthWidget(
                    healthyList[index],
                  ),
                ),
              ),
              bannerAdWidget(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                alignment: Alignment.center,
                height: screenHeight / 22,
                width: screenWidth / 3,
                child: Text(
                  "बिज़नेस",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      15,
                    ),
                  ),
                ),
              ),
              Container(
                height: screenHeight / 1.45,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  reverse: false,
                  shrinkWrap: true,
                  itemCount: vyaparDetailsList.length,
                  itemBuilder: (context, index) => businessWidget(
                    vyaparDetailsList[index],
                  ),
                ),
              ),
              bannerAdWidget(),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                alignment: Alignment.center,
                height: screenHeight / 22,
                width: screenWidth / 3,
                child: Text(
                  "अध्यात्म",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      15,
                    ),
                  ),
                ),
              ),
              Container(
                height: screenHeight / 1.45,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  reverse: false,
                  shrinkWrap: true,
                  itemCount: adhyatmicDetailsList.length,
                  itemBuilder: (context, index) => adhaytamWidget(
                    adhyatmicDetailsList[index],
                  ),
                ),
              ),
              bannerAdWidget(),
            ],
          ),
        ],
      ),
    );
  }

  Widget newsCardWidget(GaramMasalaModel items) {
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

  Widget technologyWidget(TechnologyDetailsModel items) {
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

  Widget healthWidget(HealthyDetailsModel items) {
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

  Widget businessWidget(VyaparDetailsModel items) {
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

  Widget adhaytamWidget(AdhyatmicDetailsModel items) {
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

//----------------------------------API CALL
  Future getGaramMasalaNews() async {
    var url = Settings.garamMasalaNews;
    var res = await GlobalFunction.apiGetRequestae(url);

    var result = jsonDecode(res);

    var _cryptoList = result as List;
    setState(() {
      garamMaslaList.clear();
      var listdata =
          _cryptoList.map((e) => GaramMasalaModel.fromjson(e)).toList();
      garamMaslaList.addAll(listdata);
    });
  }

  Future gettechnologyNews() async {
    var url = Settings.techNews;
    var res = await GlobalFunction.apiGetRequestae(url);

    var result = jsonDecode(res);

    var _cryptoList = result as List;
    setState(() {
      techList.clear();
      var listdata =
          _cryptoList.map((e) => TechnologyDetailsModel.fromjson(e)).toList();
      techList.addAll(listdata);
    });
  }

  Future getHealthNews() async {
    var url = Settings.healthNews;
    var res = await GlobalFunction.apiGetRequestae(url);

    var result = jsonDecode(res);

    var _cryptoList = result as List;
    setState(() {
      healthyList.clear();
      var listdata =
          _cryptoList.map((e) => HealthyDetailsModel.fromjson(e)).toList();
      healthyList.addAll(listdata);
    });
  }

  Future getbusinessNews() async {
    var url = Settings.businessNews;
    var res = await GlobalFunction.apiGetRequestae(url);

    var result = jsonDecode(res);

    var _cryptoList = result as List;
    setState(() {
      vyaparDetailsList.clear();
      var listdata =
          _cryptoList.map((e) => VyaparDetailsModel.fromjson(e)).toList();
      vyaparDetailsList.addAll(listdata);
    });
  }

  Future getadhyatmDetailsNews() async {
    var url = Settings.adhyatmicDetails;
    var res = await GlobalFunction.apiGetRequestae(url);

    var result = jsonDecode(res);

    var _cryptoList = result as List;
    setState(() {
      adhyatmicDetailsList.clear();
      var listdata =
          _cryptoList.map((e) => AdhyatmicDetailsModel.fromjson(e)).toList();
      adhyatmicDetailsList.addAll(listdata);
    });
  }
}
