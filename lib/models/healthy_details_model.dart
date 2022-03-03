class HealthyDetailsModel {
  String newsId = "";
  String newsTiming = "";
  String newstitle = "";
  String newsContent = "";
  String newsImage = "";
  String newsDiscription = "";

  HealthyDetailsModel({
    required this.newsId,
    required this.newsTiming,
    required this.newstitle,
    required this.newsContent,
    required this.newsImage,
    required this.newsDiscription,
  });

  factory HealthyDetailsModel.fromjson(Map<String, dynamic> json) {
    return HealthyDetailsModel(
      newsId: json["id"].toString(),
      newsTiming: json["modified"].toString(),
      newstitle: json["title"]["rendered"].toString(),
      newsContent: json["content"]["rendered"].toString(),
      newsImage: json["featured_image"].toString(),
      newsDiscription: json["content"]["rendered"].toString(),
    );
  }
  Map<String, dynamic> tojson() {
    final Map<String, dynamic> healthyList = new Map<String, dynamic>();

    healthyList['id'] = this.newsId;
    healthyList['modified'] = this.newsTiming;
    healthyList['title']['rendered'] = this.newstitle;
    healthyList['content']['rendered'] = this.newsContent;
    healthyList['featured_image'] = this.newsImage;
    healthyList["content"]["rendered"] = this.newsDiscription;

    return healthyList;
  }
}
