import 'package:flutter/material.dart';
import 'package:katuturangsatwa/util/data_class.dart';

import '../service/http_service.dart';
import '../util/sharedPreferences.dart';

class Users with ChangeNotifier {
  User? _user;

  User? get user {
    return _user;
  }

  Future<void> getUserData() async {
    var id = await getUserId();

    if(id != null) {
      try {
        var data = await HttpService().getUserData(id);
        _user = User.fromJson(data);
      } catch (error) {
        rethrow;
      }
    }
    notifyListeners();
  }

  removeUserData() {
    _user = null;
    notifyListeners();
  }
}