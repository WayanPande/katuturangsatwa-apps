import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../util/data_class.dart';


class HttpService {
  Future<List<dynamic>> getStories() async {
    final String storyURL;
    storyURL = "${dotenv.env['API_URL']}api/v1/stories?limit=5";
    http.Response res = await http.get(Uri.parse(storyURL));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<Map<String, dynamic>> getStoryDetail(int id) async {
    final String storyURL;
    storyURL = "${dotenv.env['API_URL']}api/v1/stories/$id";
    http.Response res = await http.get(Uri.parse(storyURL));

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<dynamic>> getStoriesPaginate(int limit, int page, [String keyword = ""]) async {
    final String storyURL;
    storyURL = "${dotenv.env['API_URL']}api/v1/stories?limit=$limit&page=$page&keyword=$keyword";
    http.Response res = await http.get(Uri.parse(storyURL));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
