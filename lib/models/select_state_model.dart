class SelectStateModel {
  String stateName = "";
  String stateId = "";

  SelectStateModel({
    required this.stateName,
    required this.stateId,
  });

  factory SelectStateModel.fromjson(Map<String, dynamic> json) {
    return SelectStateModel(
      stateName: json["name"].toString(),
      stateId: json["id"].toString(),
    );
  }
  Map<String, dynamic> tojson() {
    final Map<String, dynamic> stateCategory = new Map<String, dynamic>();

    stateCategory['name'] = this.stateName;
    stateCategory['id'] = this.stateId;

    return stateCategory;
  }
}
