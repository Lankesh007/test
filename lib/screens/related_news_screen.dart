import 'dart:convert';

import 'package:asb_news/models/popularNewsModel.dart';
import 'package:asb_news/models/releated_news_model.dart';
import 'package:asb_news/screens/google_ads_screen.dart';
import 'package:asb_news/screens/samachar_screen.dart';
import 'package:asb_news/utils/api.dart';
import 'package:asb_news/utils/color.dart';
import 'package:asb_news/utils/globalFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RelatedNewsScreen extends StatefulWidget {
  final id;
  final title;
  final image;
  final description;
  const RelatedNewsScreen(
      {required this.id,
      required this.title,
      required this.image,
      required this.description,
      Key? key})
      : super(key: key);

  @override
  _RelatedNewsScreenState createState() => _RelatedNewsScreenState();
}

class _RelatedNewsScreenState extends State<RelatedNewsScreen> {
  void initState() {
    // TODO: implement initState
    _initFunction();

    super.initState();
  }

  _initFunction() async {
    getPopularNewsDetails();
    getRelatedNewsDetails();
  }

  List<RelatedNewsModel> relatedNewsList = [];
  List<PopularNewsModel> popularNewsList = [];
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
          "Related News",
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
                            Container(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  // physics: NeverScrollableScrollPhysics(),
                                  reverse: false,
                                  // shrinkWrap: true,
                                  itemCount: relatedNewsList.length,
                                  itemBuilder: (context, index) =>
                                      relatedNewsWidget(
                                    relatedNewsList[index],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    bannerAdWidget(),
                    SizedBox(
                      height: 10,
                    ),
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
                    Container(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 1,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          reverse: false,
                          // shrinkWrap: true,
                          itemCount: popularNewsList.length,
                          itemBuilder: (context, index) => popularNewsWidget(
                            popularNewsList[index],
                          ),
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

  Widget relatedNewsWidget(RelatedNewsModel items) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SamacharScreen(
                      id: items.id,
                      title: items.title,
                      image: items.image,
                      description: items.description,
                      imageUrl: items.imageUrl,
                    )));
      },
      child: Container(
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
                          items.image,
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
                  items.title,
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
                  items.timing,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget popularNewsWidget(PopularNewsModel itemss) {
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
                  id: itemss.id,
                  title: itemss.title,
                  image: itemss.image,
                  description: itemss.description,
                  imageUrl: itemss.imageUrl,
                ),
              ),
            );
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
                                itemss.image,
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
                                  itemss.title,
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
                                  itemss.timing,
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
        SizedBox(
          height: 10,
        )
      ],
    );
  }

//------------------------------Api Call
  Future getRelatedNewsDetails() async {
    var url = Settings.relatedNews;
    var res = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(res);

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
    var result = jsonDecode(res);

    var _cryptoList = result as List;
    setState(() {
      popularNewsList.clear();
      var listdata =
          _cryptoList.map((e) => PopularNewsModel.fromjson(e)).toList();
      popularNewsList.addAll(listdata);
    });
  }
}
