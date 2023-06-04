
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:katuturangsatwa/util/data_class.dart';

import '../service/http_service.dart';

class Stories with ChangeNotifier {
  List<Story> _storyList = [];
  StoryDetail? _storyDetail;

  List<Story> get storyList {
    return [..._storyList];
  }

  StoryDetail? get storyDetail {
    return _storyDetail;
  }

  Future<void> getStories() async {
    try {
      var data = await HttpService().getStories();
      var finalData = data.map((e) => Story.fromJson(e)).toList();
      _storyList = finalData;

    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> getStoryDetail(int id) async {
    try {
      var data = await HttpService().getStoryDetail(id);
      _storyDetail = StoryDetail.fromJson(data);
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

}