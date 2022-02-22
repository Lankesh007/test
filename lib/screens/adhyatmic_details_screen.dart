import 'package:asb_news/screens/dhamakedar_news.dart';
import 'package:asb_news/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class AdhyatmicDetailsScreen extends StatefulWidget {
  final id;
  final title;
  final image;
  final description;
  const AdhyatmicDetailsScreen(
      {required this.id,
      required this.title,
      required this.image,
      required this.description,
      Key? key})
      : super(key: key);

  @override
  _AdhyatmicDetailsScreenState createState() => _AdhyatmicDetailsScreenState();
}

class _AdhyatmicDetailsScreenState extends State<AdhyatmicDetailsScreen> {
  @override
  double screenHeight = 0;
  double screenWidth = 0;
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(
          "अध्यात्म",
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
                      builder: (context) => DhamakedarNewsScreen()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: ListView(
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
              // Container(
              //   child: Text(
              //     widget.description,
              //   ),
              // ),
              Html(
                data: widget.description,
              ),
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
                      // Container(
                      //   child: SizedBox(
                      //     height: MediaQuery.of(context).size.height / 4,
                      //     width: MediaQuery.of(context).size.width,
                      //     child: ListView.builder(
                      //       scrollDirection: Axis.horizontal,
                      //       // physics: NeverScrollableScrollPhysics(),
                      //       reverse: false,
                      //       // shrinkWrap: true,
                      //       itemCount: relatedNewsList.length,
                      //       itemBuilder: (context, index) => relatedNewsWidget(
                      //         relatedNewsList[index],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      relatedNewsWidget(),
                    ],
                  ),
                ),
              ),
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

              popularNewsWidget(),
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

  Widget relatedNewsWidget() {
    return Container(
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
                        "https://www.youandthemat.com/wp-content/uploads/nature-2-26-17.jpg",
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
                "If the [style] argument is null, the text will use the style from the closest enclosing [DefaultTextStyle]",
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
                "7 hours ago",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget popularNewsWidget() {
    return InkWell(
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
                            "https://media.cntraveler.com/photos/60596b398f4452dac88c59f8/16:9/w_3999,h_2249,c_limit/MtFuji-GettyImages-959111140.jpg",
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
                              "items.newstitle",
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
                              "items.newsTiming",
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
    );
  }
}
