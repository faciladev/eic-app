import 'dart:convert' show json, jsonDecode, utf8;

import 'package:eicapp/providers/config_profider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eicapp/models/news.dart';
import 'package:provider/provider.dart';

class NewsProvider extends ChangeNotifier {
  List<dynamic> allNews;
  News selectedNews;

  final BuildContext context;

  NewsProvider({this.context});

  Future<void> fetchAllNews() async {
    String url =
        Provider.of<ConfigProvider>(context, listen: false).config.apiBase;
    final response = await http.get(url + 'news?format=json');

    if (response.statusCode == 200) {
      allNews = json
          .decode(utf8.decode(response.bodyBytes))
          .map((json) => News.fromJson(json))
          .toList();
      // allNews =
      //     jsonDecode(response.body).map((json) => News.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load news');
    }
  }

  void selectNewsByAttributes(Map<String, dynamic> attributes) async {
    if (allNews == null) {
      await fetchAllNews();
    }

    selectedNews = allNews.singleWhere((news) {
      return attributes.keys.every((key) {
        Map<String, dynamic> resource = news.toMap();
        return resource[key] == attributes[key];
      });
    }, orElse: () => null);
  }

  void selectNews(int index) => selectedNews = allNews[index];
  void unselectNews() => selectedNews = null;
}
