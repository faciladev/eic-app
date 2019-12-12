import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:eicapp/models/news.dart';

class NewsProvider extends ChangeNotifier {
  List<dynamic> allNews;
  News selectedNews;

  Future<void> fetchAllNews() async {
    final response = await http.get(
        'http://ec2-18-191-74-44.us-east-2.compute.amazonaws.com:3000/news?filter[limit]=10');

    if (response.statusCode == 200) {
      allNews =
          jsonDecode(response.body).map((json) => News.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load news');
    }
  }

  void selectNews(int index) => selectedNews = allNews[index];
  void unselectNews() => selectedNews = null;
}
