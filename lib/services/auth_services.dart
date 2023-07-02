import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:katuturangsatwa/providers/users.dart';
import 'package:katuturangsatwa/util/data_class.dart';
import 'package:katuturangsatwa/util/sharedPreferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final StreamController<bool> _onAuthStateChange =
      StreamController.broadcast();

  Stream<bool> get onAuthStateChange => _onAuthStateChange.stream;

  Future<Map<String, dynamic>> login(LoginData data) async {
    // This is just to demonstrate the login process time.
    // In real-life applications, it is not recommended to interrupt the user experience by doing such things.
    final String storyURL;
    storyURL = "${dotenv.env['API_URL']}api/v1/sign_in";
    http.Response res = await http.post(
      Uri.parse(storyURL),
      body: {
        "username": data.username,
        "password": data.password
      },
    );
    Map<String, dynamic> body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      addUserId(body['data']['id']);
      _onAuthStateChange.add(true);
    }

    return body;
  }

  void logOut() {
    removeUserId();
    _onAuthStateChange.add(false);
  }
}
