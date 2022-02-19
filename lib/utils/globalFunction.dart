import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:asb_news/utils/api.dart';
import 'package:http/http.dart' as http;

class GlobalFunction {
  static Future<String> apiPostRequest(url, data) async {
    String result = "";
    try {
      final response =
          await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
        'Accept': 'application/json',
        'content-type': 'application/json',
        'X-Api-Key': Settings.apiKey,
      });
      log(response.body);
      if (response.statusCode == 200) {
        result = response.body;
      } else {}
      return result;
    } catch (e) {
      log(e.toString());
      return '';
    }
  }

  static Future<String> apiGetRequestae(String url) async {
    String result = "";
    final response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'content-type': 'application/json',
      'X-Api-Key': Settings.apiKey,
    });

    if (response.statusCode == 200) {
      result = response.body;
    } else {}
    return result;
  }
  // Cash Free Payment

  static Future<String> paymentPostRequest(String url, body) async {
    try {
      var response = await http.post(Uri.parse(url),
          headers: {
            "x-client-id": "144799ad8eef160dec12af5568997441",
            "x-client-secret": "13f31ba1da4c1cd96c7cbe4702851d0153bd7cf1"
          },
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        //var body = jsonDecode(response.body);
        // List<Post> posts = [];
        // body.forEach((e) {
        //   Post post = Post.fromJson(e);
        //   posts.add(post);
        // });

        return response.body;
      } else {
        return '';
      }
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return '';
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return '';
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return '';
    }
  }
}
