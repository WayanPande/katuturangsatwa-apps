import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
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

  Future<List<dynamic>> getCategories() async {
    final String URL;
    URL = "${dotenv.env['API_URL']}api/v1/categories";
    http.Response res = await http.get(Uri.parse(URL));

    if (res.statusCode == 200) {
      List<dynamic>body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve categories.";
    }
  }

  Future<List<dynamic>> getStoriesPerCategory(String id) async {
    final String URL;
    URL = "${dotenv.env['API_URL']}api/v1/categories/$id";
    http.Response res = await http.get(Uri.parse(URL));

    if (res.statusCode == 200) {
      List<dynamic>body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve categories.";
    }
  }

  Future<List<dynamic>> getStoriesWriter(String id) async {
    final String URL;
    URL = "${dotenv.env['API_URL']}api/v1/stories/writer/$id";
    http.Response res = await http.get(Uri.parse(URL));

    if (res.statusCode == 200) {
      List<dynamic>body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve stories.";
    }
  }

  Future<int> registerStory(RegisterStory data) async {
    final String URL;
    URL = "${dotenv.env['API_URL']}api/v1/submit_satwa";
    Map<String,String> headers={
      "Content-type": "multipart/form-data"
    };

    var request = http.MultipartRequest(
      'POST', Uri.parse(URL),
    );
    request.headers.addAll(headers);
    request.files.add(
      http.MultipartFile(
          'img_satwa',
          data.img_satwa.readAsBytes().asStream(),
          data.img_satwa.lengthSync(),
          filename: "test${data.img_satwa.path.split('/').last}",
          contentType: MediaType('image','png')
      ),
    );

    request.fields["judul_satwa"] = data.judul_satwa;
    request.fields["text_satwa"]= data.text_satwa;
    request.fields["penulis_satwa"]= data.penulis_satwa;

    var res = await request.send();

    return res.statusCode;
  }

  Future<int> updateStory(UpdateStory data) async {
    final String URL;
    URL = "${dotenv.env['API_URL']}api/v1/update_satwa";
    Map<String,String> headers={
      "Content-type": "multipart/form-data"
    };

    var request = http.MultipartRequest(
      'PUT', Uri.parse(URL),
    );
    request.headers.addAll(headers);

    final img_satwa = data.img_satwa;
    if(img_satwa != null){
      request.files.add(
        http.MultipartFile(
            'img_satwa',
            img_satwa.readAsBytes().asStream(),
            img_satwa.lengthSync(),
            filename: "test${img_satwa.path.split('/').last}",
            contentType: MediaType('image', "jpg")
        ),
      );
    }

    request.fields["judul_satwa"] = data.judul_satwa;
    request.fields["text_satwa"]= data.text_satwa;
    request.fields["id"]= data.id;

    var res = await request.send();

    return res.statusCode;
  }

  Future<int> updateUser(UpdateProfile data) async {
    final String URL;
    URL = "${dotenv.env['API_URL']}api/v1/update_account";
    Map<String,String> headers={
      "Content-type": "multipart/form-data"
    };

    var request = http.MultipartRequest(
      'PUT', Uri.parse(URL),
    );
    request.headers.addAll(headers);

    final img_update = data.img_update;
    if(img_update != null){
      request.files.add(
        http.MultipartFile(
            'img_update',
            img_update.readAsBytes().asStream(),
            img_update.lengthSync(),
            filename: "test${img_update.path.split('/').last}",
            contentType: MediaType('image', "jpg")
        ),
      );
    }

    request.fields["name"] = data.name;
    request.fields["id"]= data.id;

    var res = await request.send();

    return res.statusCode;
  }

  Future<int> deleteStory(String id) async {
    final String URL;
    URL = "${dotenv.env['API_URL']}api/v1/delete_satwa/$id";
    http.Response res = await http.delete(Uri.parse(URL));

    return res.statusCode;
  }

}
