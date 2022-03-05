class TechnologyDetailsModel {
  String newsId = "";
  String newsTiming = "";
  String newstitle = "";
  String newsContent = "";
  String newsImage = "";
  String newsDiscription = "";
  String imageUrl = "";

  TechnologyDetailsModel({
    required this.newsId,
    required this.newsTiming,
    required this.newstitle,
    required this.newsContent,
    required this.newsImage,
    required this.newsDiscription,
    required this.imageUrl,
  });

  factory TechnologyDetailsModel.fromjson(Map<String, dynamic> json) {
    return TechnologyDetailsModel(
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
    final Map<String, dynamic> technologyList = new Map<String, dynamic>();

    technologyList['id'] = this.newsId;
    technologyList['modified'] = this.newsTiming;
    technologyList['title']['rendered'] = this.newstitle;
    technologyList['content']['rendered'] = this.newsContent;
    technologyList['featured_image'] = this.newsImage;
    technologyList["content"]["rendered"] = this.newsDiscription;
    technologyList["link"] = this.imageUrl;

    return technologyList;
  }
}
