import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:katuturangsatwa/util/data_class.dart';


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

  Future<List<dynamic>> getStoriesLatest([int limit = 5]) async {
    final String storyURL;
    storyURL = "${dotenv.env['API_URL']}api/v1/stories/latest?limit=$limit";
    http.Response res = await http.get(Uri.parse(storyURL));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<Map<String, dynamic>> getUserData(int id) async {
    final String URL;
    URL = "${dotenv.env['API_URL']}api/v1/user/$id";
    http.Response res = await http.get(Uri.parse(URL));

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve user.";
    }
  }

  Future<Map<String, dynamic>> registerUser(RegisterData data) async {
    final String URL;
    URL = "${dotenv.env['API_URL']}api/v1/sign_up";
    http.Response res = await http.post(
      Uri.parse(URL),
      body: {
        "username": data.username,
        "password": data.password,
        "email": data.email,
        "name": data.name,
      },
    );

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to login.";
    }
  }
}