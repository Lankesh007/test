class DeshDetailsModel {
  String newsId = "";
  String newsTiming = "";
  String newstitle = "";
  String newsContent = "";
  String newsImage = "";
  String newsDiscription = "";

  DeshDetailsModel({
    required this.newsId,
    required this.newsTiming,
    required this.newstitle,
    required this.newsContent,
    required this.newsImage,
    required this.newsDiscription,
  });

  factory DeshDetailsModel.fromjson(Map<String, dynamic> json) {
    return DeshDetailsModel(
      newsId: json["id"].toString(),
      newsTiming: json["modified"].toString(),
      newstitle: json["title"]["rendered"].toString(),
      newsContent: json["content"]["rendered"].toString(),
      newsImage: json["featured_image"].toString(),
      newsDiscription: json["content"]["rendered"].toString(),
    );
  }
  Map<String, dynamic> tojson() {
    final Map<String, dynamic> deshDetailsList = new Map<String, dynamic>();

    deshDetailsList['id'] = this.newsId;
    deshDetailsList['modified'] = this.newsTiming;
    deshDetailsList['title']['rendered'] = this.newstitle;
    deshDetailsList['content']['rendered'] = this.newsContent;
    deshDetailsList['featured_image'] = this.newsImage;
    deshDetailsList["content"]["rendered"] = this.newsDiscription;

    return deshDetailsList;
  }
}
