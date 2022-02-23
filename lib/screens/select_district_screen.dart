import 'dart:convert';
import 'package:asb_news/models/select_district_model.dart';
import 'package:asb_news/screens/homepage_screen.dart';
import 'package:asb_news/utils/api.dart';
import 'package:asb_news/utils/color.dart';
import 'package:asb_news/utils/globalFunction.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectDistrictScreen extends StatefulWidget {
  final stateId;
  const SelectDistrictScreen({required this.stateId, Key? key})
      : super(key: key);

  @override
  _SelectDistrictScreenState createState() => _SelectDistrictScreenState();
}

class _SelectDistrictScreenState extends State<SelectDistrictScreen> {
  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: const Text(
          'Select a Category',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        // action: SnackBarAction(
        //     label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  List<SelectDistrictModel> districtCategory = [];
  List<String> districtNameList = [];
  List<String> districtIdList = [];
  double screenHeight = 0;
  double screenWidth = 0;

  Future getDistrictCategory() async {
    var url = Settings.selectDistrictCategory + widget.stateId;
    var res = await GlobalFunction.apiGetRequestae(url);
    print(res);

    var result = jsonDecode(res);
    var dataList = result as List;
    setState(() {
      districtCategory.clear();
      var listdata =
          dataList.map((e) => SelectDistrictModel.fromjson(e)).toList();
      districtCategory.addAll(listdata);
    });
  }

  String valuefirst = "";
  SharedPreferences? _preferences;
  Future saveSelectdData() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    getDistrictCategory();
    saveSelectdData();
    super.initState();
  }

  String disId = '';
  String distName = "";

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Select Your District",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          Container(
            height: screenHeight / 1.25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      // physics: NeverScrollableScrollPhysics(),
                      // reverse: false,
                      // shrinkWrap: true,
                      itemCount: districtCategory.length,
                      itemBuilder: (context, i) {
                        return Container(
                          child: ListTile(
                            title: Text(
                              districtCategory[i].districtName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: InkWell(
                              onTap: () {
                                setState(() {
                                  districtCategory[i].isSelected =
                                      !districtCategory[i].isSelected;

                                  print("Selected--->Exc-->" +
                                      districtCategory[i]
                                          .isSelected
                                          .toString());

                                  if (districtCategory[i].isSelected == true) {
                                    setState(() {
                                      districtIdList.add(districtCategory[i]
                                          .districtId
                                          .toString());
                                      districtNameList.add(
                                        districtCategory[i]
                                            .districtName
                                            .toString(),
                                      );
                                    });
                                  } else {
                                    setState(() {
                                      int pos = districtIdList.indexWhere(
                                        (element) =>
                                            element ==
                                            districtCategory[i]
                                                .districtId
                                                .toString(),
                                      );

                                      if (pos >= 0) {
                                        districtIdList.removeAt(pos);
                                        districtNameList.removeAt(pos);
                                      }
                                      if (districtIdList.length <= 0) {
                                        districtIdList.clear();
                                        districtNameList.clear();
                                      }
                                    });
                                  }
                                });
                                print(
                                  'Value find here:==>' +
                                      districtIdList.toString(),
                                );
                                print("Name find here:==>" +
                                    districtNameList.toString());
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  width: 1,
                                )),
                                child: (districtCategory[i].isSelected == true)
                                    ? Icon(
                                        Icons.check,
                                        color: themeColor,
                                        size: 20,
                                      )
                                    : Container(),
                              ),
                            ),
                          ),
                        );
                        // return Container(
                        //   margin:
                        //       EdgeInsets.only(bottom: 10, left: 10, right: 10),
                        //   child: Container(
                        //     child: CheckboxListTile(
                        //       onChanged: (val) {
                        //         setState(() {
                        //           valuefirst = [i].toString();
                        //           districtCategory[i].districtId;
                        //           disId = districtCategory[i].districtId;
                        //           distName = districtCategory[i].districtName;
                        //         });
                        //       },
                        //       value:
                        //           valuefirst == [i].toString() ? true : false,
                        //       title: Text(
                        //         districtCategory[i].districtName,
                        //       ),
                        //     ),
                        //   ),
                        // );
                      }),
                ),
              ],
            ),
          ),
          newsButtonWidget(),
        ],
      ),
    );
  }

  Widget selectDistrictWidget() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget newsButtonWidget() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (districtIdList.length > 0) {
              _preferences!.setStringList('idDistrict', districtIdList);
              _preferences!.setStringList('namedistrict', districtNameList);
              _preferences!.setString('isInit', 'true');

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePageScreen(
                            districtId: districtIdList.toString(),
                            districtName: districtNameList.toString(),
                          )));
            } else {
              _showToast(context);
            }
          },
          child: Container(
            alignment: Alignment.center,
            height: screenHeight / 18,
            width: screenWidth / 1.1,
            decoration: BoxDecoration(
              color: themeColor,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Text(
              "Next",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
