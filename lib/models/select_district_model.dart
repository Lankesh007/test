class SelectDistrictModel {
  String districtName = "";
  String districtId = "";

  SelectDistrictModel({
    required this.districtName,
    required this.districtId,
  });

  factory SelectDistrictModel.fromjson(Map<String, dynamic> json) {
    return SelectDistrictModel(
      districtName: json["name"].toString(),
      districtId: json["id"].toString(),
    );
  }
  Map<String, dynamic> tojson() {
    final Map<String, dynamic> districtCategory = new Map<String, dynamic>();

    districtCategory['name'] = this.districtName;
    districtCategory['id'] = this.districtId;

    return districtCategory;
  }
}

// class SendDistrictId {
//   String districtId = "";
//   SendDistrictId({
//     required this.districtId,
//   });
//   factory SendDistrictId.fromjson(Map<String, dynamic> json) {
//     return SendDistrictId(
//       districtId: json["id"].toString(),
//     );
//   }
//   Map<String, dynamic> tojson() {
//     final Map<String, dynamic> districtIdList = new Map<String, dynamic>();

//     districtIdList['id'] = this.districtId;

//     return districtIdList;
//   }
// }
