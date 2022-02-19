import 'dart:convert';

import 'package:asb_news/models/uttarpradesh_details_model.dart';
import 'package:asb_news/screens/uttar_pradesh_details.dart';
import 'package:asb_news/utils/api.dart';
import 'package:asb_news/utils/color.dart';
import 'package:asb_news/utils/globalFunction.dart';
import 'package:flutter/material.dart';

class UttarPradeshScreen extends StatefulWidget {
  const UttarPradeshScreen({Key? key}) : super(key: key);

  @override
  _UttarPradeshScreenState createState() => _UttarPradeshScreenState();
}

class _UttarPradeshScreenState extends State<UttarPradeshScreen> {
  List<UttarPradeshDetailsModel> uttarPradeshList = [];
  var result;
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

  void initState() {
    getUttarPradeshDetails();
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UttarPradeshDetailsScreen(
                          id: uttarPradeshList[0].newsId,
                          title: uttarPradeshList[0].newstitle,
                          image: uttarPradeshList[0].newsImage,
                          description: uttarPradeshList[0].newsContent,
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
                Container(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 1.48,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      reverse: false,
                      shrinkWrap: true,
                      itemCount: uttarPradeshList.length,
                      itemBuilder: (context, index) => newsDetailsWidget(
                        uttarPradeshList[index],
                      ),
                    ),
                  ),
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
            : InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UttarPradeshDetailsScreen(
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
