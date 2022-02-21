import 'dart:convert';

import 'package:asb_news/models/bollywood_details_model.dart';
import 'package:asb_news/screens/bollywood_details_screen.dart';
import 'package:asb_news/utils/api.dart';
import 'package:asb_news/utils/color.dart';
import 'package:asb_news/utils/globalFunction.dart';
import 'package:flutter/material.dart';

class BollyWoodScreen extends StatefulWidget {
  const BollyWoodScreen({Key? key}) : super(key: key);

  @override
  _BollyWoodScreenState createState() => _BollyWoodScreenState();
}

class _BollyWoodScreenState extends State<BollyWoodScreen> {
  List<BollyWoodDetailsModel> bollywoodListDetails = [];
  Future getBollywoodDetails() async {
    var url = Settings.bollywoodDetails;
    var res = await GlobalFunction.apiGetRequestae(url);
    result = jsonDecode(res);

    var _cryptoList = result as List;
    setState(() {
      bollywoodListDetails.clear();
      var listdata =
          _cryptoList.map((e) => BollyWoodDetailsModel.fromjson(e)).toList();
      bollywoodListDetails.addAll(listdata);
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
                          builder: (context) => BollyWoodDetailsScreen(
                            id: bollywoodListDetails[0].newsId,
                            title: bollywoodListDetails[0].newstitle,
                            image: bollywoodListDetails[0].newsImage,
                            description: bollywoodListDetails[0].newsContent,
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
                              bollywoodListDetails[0].newsImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            bollywoodListDetails[0].newstitle,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              bollywoodListDetails[0].newsTiming,
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
                  Container(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        reverse: false,
                        shrinkWrap: true,
                        itemCount: bollywoodListDetails.length,
                        itemBuilder: (context, index) => newsDetailsWidget(
                          bollywoodListDetails[index],
                        ),
                      ),
                    ),
                  ),
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

  Widget newsDetailsWidget(BollyWoodDetailsModel items) {
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
                      builder: (context) => BollyWoodDetailsScreen(
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
