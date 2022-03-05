class BollyWoodDetailsModel {
  String newsId = "";
  String newsTiming = "";
  String newstitle = "";
  String newsContent = "";
  String newsImage = "";
  String newsDiscription = "";
  String imageUrl = "";

  BollyWoodDetailsModel({
    required this.newsId,
    required this.newsTiming,
    required this.newstitle,
    required this.newsContent,
    required this.newsImage,
    required this.newsDiscription,
    required this.imageUrl,
  });

  factory BollyWoodDetailsModel.fromjson(Map<String, dynamic> json) {
    return BollyWoodDetailsModel(
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
    final Map<String, dynamic> bollywoodListDetails =
        new Map<String, dynamic>();

    bollywoodListDetails['id'] = this.newsId;
    bollywoodListDetails['modified'] = this.newsTiming;
    bollywoodListDetails['title']['rendered'] = this.newstitle;
    bollywoodListDetails['content']['rendered'] = this.newsContent;
    bollywoodListDetails['featured_image'] = this.newsImage;
    bollywoodListDetails["content"]["rendered"] = this.newsDiscription;
    bollywoodListDetails["link"] = this.imageUrl;

    return bollywoodListDetails;
  }
}
