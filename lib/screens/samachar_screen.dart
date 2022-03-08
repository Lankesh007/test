import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:asb_news/models/bollywood_details_model.dart';
import 'package:asb_news/models/dunia_details_model.dart';
import 'package:asb_news/models/khel_model.dart';
import 'package:asb_news/models/popularNewsModel.dart';
import 'package:asb_news/models/releated_news_model.dart';
import 'package:asb_news/screens/dhamakedar_news.dart';
import 'package:asb_news/screens/google_ads_screen.dart';
import 'package:asb_news/screens/popular_news_screen.dart';
import 'package:asb_news/screens/related_news_screen.dart';
import 'package:asb_news/screens/tabs/home_screen.dart';
import 'package:asb_news/utils/adHelper.dart';
import 'package:asb_news/utils/api.dart';
import 'package:asb_news/utils/color.dart';
import 'package:asb_news/utils/globalFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class SamacharScreen extends StatefulWidget {
  final id;
  final title;
  final image;
  final description;
  final imageUrl;
  const SamacharScreen({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  _SamacharScreenState createState() => _SamacharScreenState();
}

class _SamacharScreenState extends State<SamacharScreen> {
  late InterstitialAd myInterstitialAd;

  void dispose() {
    _interstitialAd?.dispose();

    super.dispose();
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  InterstitialAd? _interstitialAd;

  bool _isInterstitialAdReady = false;

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              HomeScreen(
                districtIdList: [],
                districtNameList: [],
              );
            },
          );

          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  void onNewLevel(int level, drawing, String clue) {
    if (level >= 3 && !_isInterstitialAdReady) {
      _loadInterstitialAd();
    }
  }

  late String _url = "";

  double screenHeight = 0;
  var result;
  List<RelatedNewsModel> relatedNewsList = [];
  List<PopularNewsModel> popularNewsList = [];
  List<BollyWoodDetailsModel> bollywoodListDetails = [];
  List<KhelDetailsModel> khelDetailsList = [];
  List<DuniaDetailsModel> duniaDetailsList = [];
  double screenWidth = 0;
  String playStoreUrl =
      "https://play.google.com/store/apps/details?id=com.asbnewsindia";

  @override
  void initState() {
    // TODO: implement initState
    _initFunction();
    MobileAds.instance.initialize();

    super.initState();
  }

  _initFunction() async {
    getPopularNewsDetails();
    getRelatedNewsDetails();
    getBollyWoodNews();
    getKhelDetails();
    getDuniaDetails();
    _loadInterstitialAd();
    _initGoogleMobileAds();
    _url = widget.imageUrl.toString();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        _interstitialAd?.show();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DhamakedarNewsScreen()));
        return false;
      },
      child: Scaffold(
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
          leading: IconButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => DhamakedarNewsScreen()));
                // Navigator.pop(context);

                if (_isInterstitialAdReady) {
                  _interstitialAd?.show();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DhamakedarNewsScreen()));
                  Navigator.pop(context);
                }
                // } else {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => DhamakedarNewsScreen()));
                //   Navigator.pop(context);
                // }
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
                      shareWidget(),
                      Html(
                        data: widget.description,
                        style: {
                          widget.description: Style(
                            fontSize: FontSize.larger,
                            fontWeight: FontWeight.bold,
                          ),
                        },
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
                                  height:
                                      MediaQuery.of(context).size.height / 4,
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
                            "बॉलीवुड",
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
                            itemCount: bollywoodListDetails.length,
                            itemBuilder: (context, index) => bollywoodWidget(
                              bollywoodListDetails[index],
                            ),
                          ),
                        ),
                      ),
                      bannerAdWidget(),
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
                            "खेल",
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
                            itemCount: khelDetailsList.length,
                            itemBuilder: (context, index) => khelWidget(
                              khelDetailsList[index],
                            ),
                          ),
                        ),
                      ),
                      bannerAdWidget(),
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
                            "दुनिया",
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
                            itemCount: duniaDetailsList.length,
                            itemBuilder: (context, index) => duniaWidget(
                              duniaDetailsList[index],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  bannerAdWidget(),
                ],
              ),
        bottomNavigationBar: Container(
          height: screenHeight / 14,
          width: screenWidth,
          child: bannerAdWidget(),
        ),
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

  Widget relatedNewsWidget(RelatedNewsModel items) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RelatedNewsScreen(
                      id: items.id,
                      title: items.title,
                      image: items.image,
                      description: items.description,
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
                builder: (context) => PopularNewsScreen(
                  id: itemss.id,
                  title: itemss.title,
                  image: itemss.image,
                  description: itemss.description,
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
                                    fontSize: 16,
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

  Widget bollywoodWidget(BollyWoodDetailsModel itemss) {
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
                builder: (context) => PopularNewsScreen(
                  id: itemss.newsId,
                  title: itemss.newstitle,
                  image: itemss.newsImage,
                  description: itemss.newsDiscription,
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
                                itemss.newsImage,
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
                                  itemss.newstitle,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
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
                                  itemss.newsTiming,
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

  Widget shareWidget() {
    return InkWell(
      onTap: () async {
        final imageUrl = '${widget.image}';
        final uri = Uri.parse(imageUrl);
        final response = await http.get(uri);
        final bytes = response.bodyBytes;
        final temp = await getTemporaryDirectory();
        final path = '${temp.path}/image.jpg';
        log('IMAhgsfds===>   $path');
        log(imageUrl);
        File(path).writeAsBytesSync(bytes);
        await Share.shareFiles([path],
            text:
                '*${widget.title}* "\n${widget.imageUrl}" \n*ताजा खबरे सबसे पहले पाने के लिए नीचे क्लिक कर ASB News India एप इंस्टॉल करे*  "\n${playStoreUrl}" ');
        // Share.share(
        //     "*${widget.title}*" + "\nअभी डाउनलोड करे " + playStoreUrl + "");
      },
      child: Container(
        height: screenHeight / 25,
        width: screenWidth,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "खबर शेयर करे ",
              style: TextStyle(
                color: themeColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              Icons.share,
              color: themeColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget khelWidget(KhelDetailsModel itemss) {
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
                builder: (context) => PopularNewsScreen(
                  id: itemss.newsId,
                  title: itemss.newstitle,
                  image: itemss.newsImage,
                  description: itemss.newsDiscription,
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
                                itemss.newsImage,
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
                                  itemss.newstitle,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
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
                                  itemss.newsTiming,
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

  Widget duniaWidget(DuniaDetailsModel itemss) {
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
                builder: (context) => PopularNewsScreen(
                  id: itemss.newsId,
                  title: itemss.newstitle,
                  image: itemss.newsImage,
                  description: itemss.newsDiscription,
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
                                itemss.newsImage,
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
                                  itemss.newstitle,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
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
                                  itemss.newsTiming,
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

  File? _displayImage;

  Future<void> _download() async {
    final response = await http.get(Uri.parse(_url));

    // Get the image name
    final imageName = path.basename(_url);
    // Get the document directory path
    final appDir = await getApplicationDocumentsDirectory();

    // This is the saved image path
    // You can use it to display the saved image later
    final localPath = path.join(appDir.path, imageName);

    // Downloading
    final imageFile = File(localPath);
    await imageFile.writeAsBytes(response.bodyBytes);

    setState(() {
      _displayImage = imageFile;
    });
    log('File===> $_displayImage');
  }
//------------------------------Api Call

  Future getRelatedNewsDetails() async {
    var url = Settings.relatedNews;
    var res = await GlobalFunction.apiGetRequestae(url);
    result = jsonDecode(res);

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
    result = jsonDecode(res);

    var _cryptoList = result as List;
    setState(() {
      popularNewsList.clear();
      var listdata =
          _cryptoList.map((e) => PopularNewsModel.fromjson(e)).toList();
      popularNewsList.addAll(listdata);
    });
  }

  Future getBollyWoodNews() async {
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

  Future getKhelDetails() async {
    var url = Settings.khelNews;
    var res = await GlobalFunction.apiGetRequestae(url);
    result = jsonDecode(res);

    var _cryptoList = result as List;
    setState(() {
      khelDetailsList.clear();
      var listdata =
          _cryptoList.map((e) => KhelDetailsModel.fromjson(e)).toList();
      khelDetailsList.addAll(listdata);
    });
  }

  Future getDuniaDetails() async {
    var url = Settings.duniaNews;
    var res = await GlobalFunction.apiGetRequestae(url);
    result = jsonDecode(res);

    var _cryptoList = result as List;
    setState(() {
      duniaDetailsList.clear();
      var listdata =
          _cryptoList.map((e) => DuniaDetailsModel.fromjson(e)).toList();
      duniaDetailsList.addAll(listdata);
    });
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

  Widget bottomADD() {
    return Container(
      child: AdWidget(
        ad: AdMobService.createBannerAd()..load(),
        key: UniqueKey(),
      ),
      width: screenWidth,
      height: 50.0,
      alignment: Alignment.center,
    );
  }
}
