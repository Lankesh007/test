import 'package:asb_news/models/news_by_select_district_model.dart';

class UserNewsModel {
  String id = "";
  String title = '';
  List<NewsBySelectDistrict> districtNewsList = [];

  UserNewsModel({
    required this.id,
    required this.title,
    required this.districtNewsList,
  });
}
