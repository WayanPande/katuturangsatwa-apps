
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:katuturangsatwa/util/data_class.dart';

import '../service/http_service.dart';

class Stories with ChangeNotifier {
  List<Story> _storyList = [];
  List<Story> _storyListLatest = [];
  StoryDetail? _storyDetail;
  List<Categories> _categoryList = [];

  List<Categories> get categoryList {
    return [..._categoryList];
  }

  List<Story> get storyList {
    return [..._storyList];
  }

  List<Story> get storyListLatest {
    return [..._storyListLatest];
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

  Future<void> getStoriesLatest() async {
    try {
      var data = await HttpService().getStoriesLatest();
      var finalData = data.map((e) => Story.fromJson(e)).toList();
      _storyListLatest = finalData;

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

  Future<void> getCategories() async {
    try {
      var data = await HttpService().getCategories();
      var finalData = data.map((e) => Categories.fromJson(e)).toList();
      _categoryList = finalData;

    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

}