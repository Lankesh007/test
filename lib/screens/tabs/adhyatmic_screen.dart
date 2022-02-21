import 'dart:convert';
import 'package:asb_news/models/adhyatmic_details_model.dart';
import 'package:asb_news/screens/adhyatmic_details_screen.dart';
import 'package:asb_news/utils/api.dart';
import 'package:asb_news/utils/color.dart';
import 'package:asb_news/utils/globalFunction.dart';
import 'package:flutter/material.dart';

class AdhyatmicScreen extends StatefulWidget {
  const AdhyatmicScreen({Key? key}) : super(key: key);

  @override
  _AdhyatmicScreenState createState() => _AdhyatmicScreenState();
}

class _AdhyatmicScreenState extends State<AdhyatmicScreen> {
  List<AdhyatmicDetailsModel> adhyatmicDetailsList = [];
  var result;
  Future getAdhytmicDetails() async {
    var url = Settings.adhyatmicDetails;
    var res = await GlobalFunction.apiGetRequestae(url);
    result = jsonDecode(res);
    var _cryptoList = result as List;

    setState(() {
      adhyatmicDetailsList.clear();

      var listdata =
          _cryptoList.map((e) => AdhyatmicDetailsModel.fromjson(e)).toList();
      adhyatmicDetailsList.addAll(listdata);
    });
  }

  void initState() {
    getAdhytmicDetails();
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
                        builder: (context) => AdhyatmicDetailsScreen(
                          id: adhyatmicDetailsList[0].newsId,
                          title: adhyatmicDetailsList[0].newstitle,
                          image: adhyatmicDetailsList[0].newsImage,
                          description: adhyatmicDetailsList[0].newsContent,
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
                            adhyatmicDetailsList[0].newsImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          adhyatmicDetailsList[0].newstitle,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            adhyatmicDetailsList[0].newsTiming,
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
                      itemCount: adhyatmicDetailsList.length,
                      itemBuilder: (context, index) => newsDetailsWidget(
                        adhyatmicDetailsList[index],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget newWidget(AdhyatmicDetailsModel item) {
    return Container(
      child: Text(item.newsId),
    );
  }

  Widget newsDetailsWidget(AdhyatmicDetailsModel items) {
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
                      builder: (context) => AdhyatmicDetailsScreen(
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
                                          // top: 10,
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
}
