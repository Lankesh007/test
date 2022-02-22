import 'package:asb_news/screens/homepage_screen.dart';
import 'package:asb_news/utils/color.dart';
import 'package:flutter/material.dart';

class DhamakedarNewsScreen extends StatefulWidget {
  const DhamakedarNewsScreen({Key? key}) : super(key: key);

  @override
  _DhamakedarNewsScreenState createState() => _DhamakedarNewsScreenState();
}

class _DhamakedarNewsScreenState extends State<DhamakedarNewsScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        leading: IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>
              //         HomePageScreen(districtId: "", districtName: ""),
              //   ),
              // );
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
                  "धमाकेदार समाचार",
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
            ],
          ),
          newsCardWidget(),
          newsCardWidget(),
          newsCardWidget(),
          newsCardWidget(),
          newsCardWidget(),
          newsCardWidget(),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                alignment: Alignment.center,
                height: screenHeight / 22,
                width: screenWidth / 3,
                child: Text(
                  "बॉलीवुड",
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
            ],
          ),
        ],
      ),
    );
  }

  Widget newsCardWidget() {
    return Column(
      children: [
        SizedBox(
          height: 0,
        ),
        InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => NewsDetaailsScreen(
            //       id: items.newsId,
            //       title: items.newstitle,
            //       image: items.newsImage,
            //       description: items.newsContent,
            //     ),
            //   ),
            // );
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
                                "",
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
                                  "kjasghf,adsbjlgf",
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
                                  "7 hours ago",
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
