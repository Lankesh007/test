import 'dart:convert';
import 'dart:developer';
import 'package:asb_news/models/pushNotification/pushNotification.dart';
import 'package:asb_news/models/tab_bar_details_model.dart';
import 'package:asb_news/screens/tabs/adhyatmic_screen.dart';
import 'package:asb_news/screens/tabs/bollywood_screen.dart';
import 'package:asb_news/screens/tabs/desh_screen.dart';
import 'package:asb_news/screens/tabs/dunia_screen.dart';
import 'package:asb_news/screens/tabs/healthy_screen.dart';
import 'package:asb_news/screens/tabs/home_screen.dart';
import 'package:asb_news/screens/tabs/khel_tab_screen.dart';
import 'package:asb_news/screens/tabs/technology_screen.dart';
import 'package:asb_news/screens/tabs/uttarpradesh_screen.dart';
import 'package:asb_news/screens/tabs/vyapar_screen.dart';
import 'package:asb_news/utils/api.dart';
import 'package:asb_news/utils/color.dart';
import 'package:asb_news/utils/globalFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:new_version/new_version.dart';

class HomePageScreen extends StatefulWidget {
  final List districtIdList;
  final List districtNameList;

  const HomePageScreen(
      {required this.districtIdList, required this.districtNameList, Key? key})
      : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<TabBarDetailsModel> tabBarDetails = [];

  Future getTabBarDetails() async {
    var url = Settings.tabBarDetails;
    var res = await GlobalFunction.apiGetRequestae(url);

    var result = jsonDecode(res);
    if (result["status"] == 1) {
      var _cryptoList = result["data"] as List;
      setState(() {
        tabBarDetails.clear();
        var listdata =
            _cryptoList.map((e) => TabBarDetailsModel.fromjson(e)).toList();
        tabBarDetails.addAll(listdata);
      });
    }
    // districtId = result[0]["id"].toString();
    // districtName = result[0]["name"].toString();
    // log("Id===>" + districtId + "++++" + districtName);
    // setState(() {});
  }

  double screenHeight = 0;
  double screenWidth = 0;

  void initState() {
    // TODO: implement initState
    getTabBarDetails();
    _changeVersion();
    PushNotificationsManager().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              drawerDetailsWidget(),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: themeColor,
            size: 30,
          ),
          // automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Container(
            margin: const EdgeInsets.only(
                // top: 10,
                ),
            alignment: Alignment.center,
            height: 40,
            child: Image.asset(
              "assets/asbnews-header.png",
            ),
          ),
          bottom: PreferredSize(
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    color: themeColor,
                    child: TabBar(
                        isScrollable: true,
                        unselectedLabelColor: Colors.white,
                        indicatorColor: Colors.white,
                        tabs: [
                          Tab(
                            child: Container(
                                margin: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Text(
                                  "होम",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            // "Home",
                          ),
                          Tab(
                            child: Container(
                                margin: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Text(
                                  "देश",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            // "Home",
                          ),
                          Tab(
                            child: Container(
                                margin: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Text(
                                  "प्रदेश एवं जनपद",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            // "Home",
                          ),
                          Tab(
                            child: Container(
                                margin: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Text(
                                  "खेल",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            // "Home",
                          ),
                          Tab(
                            child: Container(
                                margin: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Text(
                                  "बॉलीवुड",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            // "Home",
                          ),
                          Tab(
                            child: Container(
                                margin: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Text(
                                  "टेक्नोलॉजी",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            // "Home",
                          ),
                          Tab(
                            child: Container(
                                margin: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Text(
                                  "अध्यात्म",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            // "Home",
                          ),
                          Tab(
                            child: Container(
                                margin: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Text(
                                  "दुनिया",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            // "Home",
                          ),
                          Tab(
                            child: Container(
                                margin: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Text(
                                  "हेल्थ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            // "Home",
                          ),
                          Tab(
                            child: Container(
                                margin: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Text(
                                  "व्यापार",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            // "Home",
                          ),
                        ]),
                  ),
                ],
              ),
              preferredSize: Size.fromHeight(30.0)),
          actions: <Widget>[
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.grey,
                )),
            Container(
              margin: const EdgeInsets.only(
                right: 10,
              ),
              child: Icon(
                Icons.notifications,
                color: themeColor,
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            HomeScreen(
              districtIdList: widget.districtIdList,
              districtNameList: widget.districtNameList,
            ),
            DeshScreen(),
            UttarPradeshScreen(),
            KhelTabScreen(),
            BollyWoodScreen(),
            TechnologyScreen(),
            AdhyatmicScreen(),
            DuniaScreen(),
            HealthyScreen(),
            VyaparScreen(),
          ],
        ),
      ),
    );
  }

  Widget drawerDetailsWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topMargin,
          Container(
            child: Text(
              "Home",
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          topMargin,
          Container(
            child: Text(
              "Latest News",
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          topMargin,
          Container(
            margin: const EdgeInsets.only(
              left: 10,
              top: 10,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "घर",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10,
              top: 10,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "अध्यात्म",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10,
              top: 10,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "उत्तर प्रदेश",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10,
              top: 10,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "देश",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10,
              top: 10,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "बॉलीवुड",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
          ),
          topMargin,
          Container(
            child: Text(
              "Other",
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10,
              top: 10,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "Privacy Policy",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10,
              top: 10,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "Contact Us",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10,
              top: 10,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "Disclamer",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _changeVersion() async {
    final newVersion = NewVersion(
      iOSId: 'com.asbnewsindia',
      androidId: 'com.asbnewsindia',
    );

    final status = await newVersion.getVersionStatus();
    if (status!.localVersion != status.storeVersion) {
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        /* dismissButtonText: 'Skip',
          updateButtonText: 'Update Now',
          dialogTitle: 'Update Available!',
          dialogText:
              'Please Update the app from ${status.localVersion} to ${status.storeVersion}',
          dismissAction: () {
            SystemNavigator.pop();
          }
           */
      );
      log('StoreVersion===> ${status.storeVersion}');
      log('StoreVersion===> ${status.releaseNotes}');
      log('DeviceVersion===> ${status.localVersion}');
    } else {
      log('Store===> ${status.storeVersion}');
      log('Local===> ${status.localVersion}');
    }

    // You can let the plugin handle fetching the status and showing a dialog,
    // or you can fetch the status and display your own dialog, or no dialog.
  }
}
