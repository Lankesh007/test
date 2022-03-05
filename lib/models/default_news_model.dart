class DefaultNewsModel {
  String newsId = "";
  String newsTiming = "";
  String newstitle = "";
  String newsContent = "";
  String newsImage = "";
  String newsDiscription = "";
  String imageUrl = "";

  DefaultNewsModel({
    required this.newsId,
    required this.newsTiming,
    required this.newstitle,
    required this.newsContent,
    required this.newsImage,
    required this.newsDiscription,
    required this.imageUrl,
  });

  factory DefaultNewsModel.fromjson(Map<String, dynamic> json) {
    return DefaultNewsModel(
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
    final Map<String, dynamic> defaultNews = new Map<String, dynamic>();

    defaultNews['id'] = this.newsId;
    defaultNews['modified'] = this.newsTiming;
    defaultNews['title']['rendered'] = this.newstitle;
    defaultNews['content']['rendered'] = this.newsContent;
    defaultNews['featured_image'] = this.newsImage;
    defaultNews["content"]["rendered"] = this.newsDiscription;
    defaultNews["link"] = this.imageUrl;

    return defaultNews;
  }
}
