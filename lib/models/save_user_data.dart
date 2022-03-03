class User {
  final String districtId;
  final String districtName;

  User({
    required this.districtId,
    required this.districtName,
  });

  User.fromMap(Map<String, dynamic> res)
      : districtId = res["districtId"],
        districtName = res["districtName"];

  Map<String, Object?> toMap() {
    return {
      districtId: 'districtId',
      districtName: 'districtName',
    };
  }
}
