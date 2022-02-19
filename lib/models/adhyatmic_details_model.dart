class AdhyatmicDetailsModel {
  String newsId = "";
  String newsTiming = "";
  String newstitle = "";
  String newsContent = "";
  String newsImage = "";
  String newsDiscription = "";

  AdhyatmicDetailsModel({
    required this.newsId,
    required this.newsTiming,
    required this.newstitle,
    required this.newsContent,
    required this.newsImage,
    required this.newsDiscription,
  });

  factory AdhyatmicDetailsModel.fromjson(Map<String, dynamic> json) {
    return AdhyatmicDetailsModel(
      newsId: json["id"].toString(),
      newsTiming: json["modified"].toString(),
      newstitle: json["title"]["rendered"].toString(),
      newsContent: json["content"]["rendered"].toString(),
      newsImage: json["featured_image"].toString(),
      newsDiscription: json["content"]["rendered"].toString(),
    );
  }
  Map<String, dynamic> tojson() {
    final Map<String, dynamic> adhyatmicDetailsList =
        new Map<String, dynamic>();

    adhyatmicDetailsList['id'] = this.newsId;
    adhyatmicDetailsList['modified'] = this.newsTiming;
    adhyatmicDetailsList['title']['rendered'] = this.newstitle;
    adhyatmicDetailsList['content']['rendered'] = this.newsContent;
    adhyatmicDetailsList['featured_image'] = this.newsImage;
    adhyatmicDetailsList["content"]["rendered"] = this.newsDiscription;

    return adhyatmicDetailsList;
  }
}
