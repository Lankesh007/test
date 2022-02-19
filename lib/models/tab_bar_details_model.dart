class TabBarDetailsModel {
  String districtName = "";
  String districtId = "";

  TabBarDetailsModel({
    required this.districtName,
    required this.districtId,
  });

  factory TabBarDetailsModel.fromjson(Map<String, dynamic> json) {
    return TabBarDetailsModel(
      districtName: json["name"].toString(),
      districtId: json["id"].toString(),
    );
  }
  Map<String, dynamic> tojson() {
    final Map<String, dynamic> tabBarDetails = new Map<String, dynamic>();

    tabBarDetails['name'] = this.districtName;
    tabBarDetails['id'] = this.districtId;

    return tabBarDetails;
  }
}
