class GaramMasalaModel {
  String newsId = "";
  String newsTiming = "";
  String newstitle = "";
  String newsContent = "";
  String newsImage = "";
  String newsDiscription = "";
  String imageUrl = "";

  GaramMasalaModel({
    required this.newsId,
    required this.newsTiming,
    required this.newstitle,
    required this.newsContent,
    required this.newsImage,
    required this.newsDiscription,
    required this.imageUrl,
  });

  factory GaramMasalaModel.fromjson(Map<String, dynamic> json) {
    return GaramMasalaModel(
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
    final Map<String, dynamic> garamMaslaList = new Map<String, dynamic>();

    garamMaslaList['id'] = this.newsId;
    garamMaslaList['modified'] = this.newsTiming;
    garamMaslaList['title']['rendered'] = this.newstitle;
    garamMaslaList['content']['rendered'] = this.newsContent;
    garamMaslaList['featured_image'] = this.newsImage;
    garamMaslaList["content"]["rendered"] = this.newsDiscription;
    garamMaslaList["link"] = this.imageUrl;

    return garamMaslaList;
  }
}
