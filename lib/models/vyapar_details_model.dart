class VyaparDetailsModel {
  String newsId = "";
  String newsTiming = "";
  String newstitle = "";
  String newsContent = "";
  String newsImage = "";
  String newsDiscription = "";
  String imageUrl = "";

  VyaparDetailsModel({
    required this.newsId,
    required this.newsTiming,
    required this.newstitle,
    required this.newsContent,
    required this.newsImage,
    required this.newsDiscription,
    required this.imageUrl,
  });

  factory VyaparDetailsModel.fromjson(Map<String, dynamic> json) {
    return VyaparDetailsModel(
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
    final Map<String, dynamic> vyaparDetailsList = new Map<String, dynamic>();

    vyaparDetailsList['id'] = this.newsId;
    vyaparDetailsList['modified'] = this.newsTiming;
    vyaparDetailsList['title']['rendered'] = this.newstitle;
    vyaparDetailsList['content']['rendered'] = this.newsContent;
    vyaparDetailsList['featured_image'] = this.newsImage;
    vyaparDetailsList["content"]["rendered"] = this.newsDiscription;
    vyaparDetailsList["link"] = this.imageUrl;

    return vyaparDetailsList;
  }
}
