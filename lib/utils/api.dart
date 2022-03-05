class Settings {
  static String BASE_URL = "https://www.asbnewsindia.com/";
  static String seelctStateCategory =
      BASE_URL + "notification/DashApi/category_type";

  static String selectDistrictCategory =
      BASE_URL + "/wp-json/wp/v2/categories?parent=";

  static String defaultNews = BASE_URL + "wp-json/wp/v2/posts?categories=492";
  static String tabBarDetails = BASE_URL + "notification/DashApi/category_list";
  static String newsSelectByDistrict =
      BASE_URL + "wp-json/wp/v2/posts?categories=";

  static String adhyatmicDetails =
      BASE_URL + "wp-json/wp/v2/posts?categories=25";
  static String uttarpradershDetails =
      BASE_URL + "wp-json/wp/v2/posts?categories=26";
  static String deshDetails = BASE_URL + "wp-json/wp/v2/posts?categories=23";
  static String bollywoodDetails =
      BASE_URL + "wp-json/wp/v2/posts?categories=24";

  static String selectStateDetails =
      BASE_URL + "wp-json/wp/v2/posts?categories=";
  static String relatedNews = BASE_URL + "wp-json/wp/v2/posts?categories=492";
  static String popularNews = BASE_URL + "wp-json/wp/v2/posts?categories=444";
  static String khelNews = BASE_URL + "wp-json/wp/v2/posts?categories=445";
  static String techNews = BASE_URL + "wp-json/wp/v2/posts?categories=448";
  static String duniaNews = BASE_URL + "wp-json/wp/v2/posts?categories=27";
  static String healthNews = BASE_URL + "wp-json/wp/v2/posts?categories=447";
  static String businessNews = BASE_URL + "wp-json/wp/v2/posts?categories=446";
  static String sliderDetails = BASE_URL + "notification/DashApi/slider_api";
  static String garamMasalaNews =
      BASE_URL + "wp-json/wp/v2/posts?categories=449";

  static String selectStateNews = BASE_URL + "wp-json/wp/v2/posts?categories=";

  static String scrollingData =
      BASE_URL + "wp-json/wp/v2/posts?categories=23&page=";

  static var apiKey = "7c4a8d09ca3762af61e59520943dc26494f8941b";
}
