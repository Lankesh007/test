import 'dart:convert';

import 'package:asb_news/models/bollywood_details_model.dart';
import 'package:asb_news/models/healthy_details_model.dart';
import 'package:asb_news/screens/google_ads_screen.dart';
import 'package:asb_news/screens/samachar_screen.dart';
import 'package:asb_news/utils/api.dart';
import 'package:asb_news/utils/color.dart';
import 'package:asb_news/utils/globalFunction.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HealthyScreen extends StatefulWidget {
  const HealthyScreen({Key? key}) : super(key: key);

  @override
  _HealthyScreenState createState() => _HealthyScreenState();
}

class _HealthyScreenState extends State<HealthyScreen> {
  List<HealthyDetailsModel> healthyList = [];
  Future getBollywoodDetails() async {
    var url = Settings.healthNews;
    var res = await GlobalFunction.apiGetRequestae(url);
    result = jsonDecode(res);

    var _cryptoList = result as List;
    setState(() {
      healthyList.clear();
      var listdata =
          _cryptoList.map((e) => HealthyDetailsModel.fromjson(e)).toList();
      healthyList.addAll(listdata);
    });
  }

  void initState() {
    getBollywoodDetails();
    super.initState();
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
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SamacharScreen(
                            id: healthyList[0].newsId,
                            title: healthyList[0].newstitle,
                            image: healthyList[0].newsImage,
                            description: healthyList[0].newsContent,
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
                              healthyList[0].newsImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            healthyList[0].newstitle,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              healthyList[0].newsTiming,
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
                      itemCount: healthyList.length,
                      itemBuilder: (context, index) => newsDetailsWidget(
                        healthyList[index],
                      ),
                    ),
                  ),
                  bannerAdWidget(),
                ],
              ),
            ),
    );
  }

  Widget newWidget(BollyWoodDetailsModel item) {
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

  Widget newsDetailsWidget(HealthyDetailsModel items) {
    return Column(
      children: [
        SizedBox(
          height: 0,
        ),
        items.newsId == 41071
            ? Container(
                height: 100,
              )
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
}
