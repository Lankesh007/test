class KhelDetailsModel {
  String newsId = "";
  String newsTiming = "";
  String newstitle = "";
  String newsContent = "";
  String newsImage = "";
  String newsDiscription = "";
  String imageUrl = "";

  KhelDetailsModel({
    required this.newsId,
    required this.newsTiming,
    required this.newstitle,
    required this.newsContent,
    required this.newsImage,
    required this.newsDiscription,
    required this.imageUrl,
  });

  factory KhelDetailsModel.fromjson(Map<String, dynamic> json) {
    return KhelDetailsModel(
      newsId: json["id"].toString(),
      newsTiming: json["modified"].toString(),
      newstitle: json["title"]["rendered"].toString(),
      newsContent: json["content"]["rendered"].toString(),
      newsImage: json["featured_image"].toString(),
      newsDiscription: json["content"]["rendered"].toString(),
      imageUrl: json["link"].toString(),
    );
  }
  Map<String, dynamic> tojson() {
    final Map<String, dynamic> khelDetailsList = new Map<String, dynamic>();

    khelDetailsList['id'] = this.newsId;
    khelDetailsList['modified'] = this.newsTiming;
    khelDetailsList['title']['rendered'] = this.newstitle;
    khelDetailsList['content']['rendered'] = this.newsContent;
    khelDetailsList['featured_image'] = this.newsImage;
    khelDetailsList["content"]["rendered"] = this.newsDiscription;
    khelDetailsList["link"] = this.imageUrl;

    return khelDetailsList;
  }
}
