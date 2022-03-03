class SliderDataModel {
  String image = "";
  String sliderId = "";
  String sliderUrl = "";
  SliderDataModel({
    required this.image,
    required this.sliderId,
    required this.sliderUrl,
  });

  factory SliderDataModel.fromjson(Map<String, dynamic> json) {
    return SliderDataModel(
      image: imgUrl + json["image"].toString(),
      sliderId: json["sliderId"].toString(),
      sliderUrl: json["url"].toString(),
    );
  }
  Map<String, dynamic> tojson() {
    final Map<String, dynamic> sliderDataList = new Map<String, dynamic>();

    sliderDataList['id'] = this.image;
    sliderDataList['slider_id'] = this.sliderId;
    sliderDataList['url'] = this.sliderUrl;

    return sliderDataList;
  }
}

String imgUrl = "https://asbnewsindia.com/notification/assets/images/slider/";
