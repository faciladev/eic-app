import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class News extends ChangeNotifier {
  final int id;
  final String image;
  final String title;
  final String url;
  final List<dynamic> content;
  final String published;

  List<dynamic> allNews;
  News selectedNews;

  News(
      {this.id,
      this.image,
      this.title,
      this.url,
      this.content,
      this.published});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      content: json['content'],
      image: 'http://www.investethiopia.gov.et' + json['image'],
      published: DateFormat.yMMMd().format(DateTime.parse(json['published'])),
      title: json['title'],
      url: json['url'],
    );
  }

  Future<void> fetchAllNews() async {
    final response = await http.get('http://10.0.2.2:3000/news');

    if (response.statusCode == 200) {
      allNews =
          jsonDecode(response.body).map((json) => News.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load news');
    }
  }

  void selectNews(int index) => selectedNews = allNews[index];
}
