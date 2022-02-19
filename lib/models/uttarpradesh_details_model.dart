class UttarPradeshDetailsModel {
  String newsId = "";
  String newsTiming = "";
  String newstitle = "";
  String newsContent = "";
  String newsImage = "";
  String newsDiscription = "";

  UttarPradeshDetailsModel({
    required this.newsId,
    required this.newsTiming,
    required this.newstitle,
    required this.newsContent,
    required this.newsImage,
    required this.newsDiscription,
  });

  factory UttarPradeshDetailsModel.fromjson(Map<String, dynamic> json) {
    return UttarPradeshDetailsModel(
      newsId: json["id"].toString(),
      newsTiming: json["modified"].toString(),
      newstitle: json["title"]["rendered"].toString(),
      newsContent: json["content"]["rendered"].toString(),
      newsImage: json["featured_image"].toString(),
      newsDiscription: json["content"]["rendered"].toString(),
    );
  }
  Map<String, dynamic> tojson() {
    final Map<String, dynamic> uttarPradeshList = new Map<String, dynamic>();

    uttarPradeshList['id'] = this.newsId;
    uttarPradeshList['modified'] = this.newsTiming;
    uttarPradeshList['title']['rendered'] = this.newstitle;
    uttarPradeshList['content']['rendered'] = this.newsContent;
    uttarPradeshList['featured_image'] = this.newsImage;
    uttarPradeshList["content"]["rendered"] = this.newsDiscription;

    return uttarPradeshList;
  }
}
