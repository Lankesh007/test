class StateNewsModel {
  String newsId = "";
  String newsTiming = "";
  String newstitle = "";
  String newsContent = "";
  String newsImage = "";
  String newsDiscription = "";
  String imageUrl = "";

  StateNewsModel({
    required this.newsId,
    required this.newsTiming,
    required this.newstitle,
    required this.newsContent,
    required this.newsImage,
    required this.newsDiscription,
    required this.imageUrl,
  });

  factory StateNewsModel.fromjson(Map<String, dynamic> json) {
    return StateNewsModel(
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
    final Map<String, dynamic> stateNewsList = new Map<String, dynamic>();

    stateNewsList['id'] = this.newsId;
    stateNewsList['modified'] = this.newsTiming;
    stateNewsList['title']['rendered'] = this.newstitle;
    stateNewsList['content']['rendered'] = this.newsContent;
    stateNewsList['featured_image'] = this.newsImage;
    stateNewsList["content"]["rendered"] = this.newsDiscription;
    stateNewsList["link"] = this.imageUrl;

    return stateNewsList;
  }
}
