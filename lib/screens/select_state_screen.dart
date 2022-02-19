import 'dart:convert';
import 'package:asb_news/main.dart';
import 'package:asb_news/models/select_state_model.dart';
import 'package:asb_news/screens/homepage_screen.dart';
import 'package:asb_news/screens/select_district_screen.dart';
import 'package:asb_news/utils/api.dart';
import 'package:asb_news/utils/globalFunction.dart';
import 'package:flutter/material.dart';

class SelectStateScreen extends StatefulWidget {
  const SelectStateScreen({Key? key}) : super(key: key);

  @override
  _SelectStateScreenState createState() => _SelectStateScreenState();
}

class _SelectStateScreenState extends State<SelectStateScreen> {
  List<SelectStateModel> stateCategory = [];
  double screenHeight = 0;
  double screenWidth = 0;

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

  @override
  void initState() {
    getStateCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Select Your State",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePageScreen(
                            districtId: null,
                            districtName: null,
                          )));
            },
            child: Text(
              "Skip",
              style: TextStyle(
                fontSize: 18,
                color: Colors.red,
                fontWeight: FontWeight.w900,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.1,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              // physics: NeverScrollableScrollPhysics(),
              // reverse: false,
              // shrinkWrap: true,
              itemCount: stateCategory.length,
              itemBuilder: (context, index) => selectStateWidget(
                stateCategory[index],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectStateWidget(SelectStateModel item) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SelectDistrictScreen(stateId: item.stateId),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            height: screenHeight / 18,
            width: screenWidth / 1.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  2,
                ),
              ),
            ),
            child: Text(
              item.stateName,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
