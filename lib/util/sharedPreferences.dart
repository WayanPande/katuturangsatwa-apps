import 'package:shared_preferences/shared_preferences.dart';

addUserId(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('user_id', id);
}

Future<int?> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? id = prefs.getInt('user_id');
  return id;
}

removeUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('user_id');
}

