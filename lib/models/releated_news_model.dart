class RelatedNewsModel {
  String id = "";
  String title = "";
  String image = "";
  String timing = "";
  String description = '';
  String imageUrl = "";

  RelatedNewsModel({
    required this.id,
    required this.title,
    required this.image,
    required this.timing,
    required this.description,
    required this.imageUrl,
  });
  factory RelatedNewsModel.fromjson(Map<String, dynamic> json) {
    return RelatedNewsModel(
      id: json["id"].toString(),
      title: json['title']['rendered'].toString(),
      image: json["featured_image"].toString(),
      timing: json["modified"].toString(),
      description: json["content"]["rendered"].toString(),
      imageUrl: json["link"].toString(),
    );
  }
  Map<String, dynamic> tojson() {
    final Map<String, dynamic> popularNewsList = new Map<String, dynamic>();

    popularNewsList['id'] = this.id;
    popularNewsList['title']['rendered'] = this.title;
    popularNewsList['featured_image'] = this.image;
    popularNewsList['modified'] = this.timing;
    popularNewsList["content"]["rendered"] = this.description;
    popularNewsList["link"] = this.imageUrl;

    return popularNewsList;
  }
}
