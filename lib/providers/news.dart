import 'dart:convert' show json, utf8;

import 'package:eicapp/providers/config_profider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eicapp/models/news.dart';
import 'package:provider/provider.dart';

class NewsProvider extends ChangeNotifier {
  List<dynamic> allNews;
  News selectedNews;
  bool isLoading = false;
  String next, prev;
  int count;

  final BuildContext context;

  NewsProvider({this.context});

  Future<void> fetchAllNews() async {
    isLoading = true;
    String url = next;
    if (next == null) {
      String baseUrl =
          Provider.of<ConfigProvider>(context, listen: false).config.apiBase;
      url = baseUrl + 'news?format=json';
    }

    final response = await http.get(url);

    if (response.statusCode == 200) {
      dynamic responseBody = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> results = responseBody['results'];
      List<dynamic> newsListing =
          results.map((json) => News.fromJson(json)).toList();
      if (next != null && allNews != null) {
        allNews.addAll(newsListing);
      } else {
        allNews = newsListing;
      }
      next = responseBody['next'];
      prev = responseBody['previous'];
      count = responseBody['count'];
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
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
