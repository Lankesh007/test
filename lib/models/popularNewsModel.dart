class PopularNewsModel {
  String id = "";
  String title = "";
  String image = "";
  String timing = "";
  String description = '';

  PopularNewsModel({
    required this.id,
    required this.title,
    required this.image,
    required this.timing,
    required this.description,
  });
  factory PopularNewsModel.fromjson(Map<String, dynamic> json) {
    return PopularNewsModel(
        id: json["id"].toString(),
        title: json['title']['rendered'].toString(),
        image: json["featured_image"].toString(),
        timing: json["modified"].toString(),
        description: json["content"]["rendered"].toString());
  }
  Map<String, dynamic> tojson() {
    final Map<String, dynamic> relatedNewsList = new Map<String, dynamic>();

    relatedNewsList['id'] = this.id;
    relatedNewsList['title']['rendered'] = this.title;
    relatedNewsList['featured_image'] = this.image;
    relatedNewsList['modified'] = this.timing;
    relatedNewsList["content"]["rendered"] = this.description;

    return relatedNewsList;
  }
}
