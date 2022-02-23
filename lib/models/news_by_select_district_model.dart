class NewsBySelectDistrict {
  String newsId = "";
  String newsTiming = "";
  String newstitle = "";
  String newsContent = "";
  String newsImage = "";
  String newsDiscription = "";
  bool isSelected = false;

  NewsBySelectDistrict({
    required this.newsId,
    required this.newsTiming,
    required this.newstitle,
    required this.newsContent,
    required this.newsImage,
    required this.newsDiscription,
    required this.isSelected,
  });

  factory NewsBySelectDistrict.fromjson(Map<String, dynamic> json) {
    return NewsBySelectDistrict(
      newsId: json["id"].toString(),
      newsTiming: json["modified"].toString(),
      newstitle: json["title"]["rendered"].toString(),
      newsContent: json["content"]["rendered"].toString(),
      newsImage: json["featured_image"].toString(),
      newsDiscription: json["content"]["rendered"].toString(),
      isSelected: false,
    );
  }
  Map<String, dynamic> tojson() {
    final Map<String, dynamic> districtNewsList = new Map<String, dynamic>();
    districtNewsList['id'] = this.newsId;
    districtNewsList['modified'] = this.newsTiming;
    districtNewsList['title']['rendered'] = this.newstitle;
    districtNewsList['content']['rendered'] = this.newsContent;
    districtNewsList['featured_image'] = this.newsImage;
    districtNewsList["content"]["rendered"] = this.newsDiscription;

    return districtNewsList;
  }
}
