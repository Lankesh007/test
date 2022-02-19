import 'package:asb_news/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SlectNewsByDistrict extends StatefulWidget {
  final id;
  final title;
  final image;
  final description;
  const SlectNewsByDistrict(
      {required this.id,
      required this.title,
      required this.image,
      required this.description,
      Key? key})
      : super(key: key);

  @override
  _SlectNewsByDistrictState createState() => _SlectNewsByDistrictState();
}

class _SlectNewsByDistrictState extends State<SlectNewsByDistrict> {
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
          "समाचार",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
}
