class DuniaDetailsModel {
  String newsId = "";
  String newsTiming = "";
  String newstitle = "";
  String newsContent = "";
  String newsImage = "";
  String newsDiscription = "";

  DuniaDetailsModel({
    required this.newsId,
    required this.newsTiming,
    required this.newstitle,
    required this.newsContent,
    required this.newsImage,
    required this.newsDiscription,
  });

  factory DuniaDetailsModel.fromjson(Map<String, dynamic> json) {
    return DuniaDetailsModel(
      newsId: json["id"].toString(),
      newsTiming: json["modified"].toString(),
      newstitle: json["title"]["rendered"].toString(),
      newsContent: json["content"]["rendered"].toString(),
      newsImage: json["featured_image"].toString(),
      newsDiscription: json["content"]["rendered"].toString(),
    );
  }
  Map<String, dynamic> tojson() {
    final Map<String, dynamic> duniaDetailsList = new Map<String, dynamic>();

    duniaDetailsList['id'] = this.newsId;
    duniaDetailsList['modified'] = this.newsTiming;
    duniaDetailsList['title']['rendered'] = this.newstitle;
    duniaDetailsList['content']['rendered'] = this.newsContent;
    duniaDetailsList['featured_image'] = this.newsImage;
    duniaDetailsList["content"]["rendered"] = this.newsDiscription;

    return duniaDetailsList;
  }
}
