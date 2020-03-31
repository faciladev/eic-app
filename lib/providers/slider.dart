import 'dart:convert';

import 'package:eicapp/providers/config_profider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Slide {
  String url;
  String caption;
  String screen_id;
  Object argument = {};

  Slide({this.url, this.caption, this.screen_id, this.argument});

  factory Slide.fromJson(Map<String, dynamic> json) {
    return Slide(
        caption: json['caption'],
        url: json['url'],
        screen_id: json['screen_id'],
        argument: json['argument']);
  }
}

class SlideProvider extends ChangeNotifier {
  List<dynamic> slides;
  BuildContext context;

  SlideProvider({this.context});

  void fetchSlides() async {
    String url =
        Provider.of<ConfigProvider>(context, listen: false).config.apiBase;
    final response = await http.get(url + 'slides?format=json');
    if (response.statusCode == 200) {
      slides = jsonDecode(response.body)
          .map((json) => Slide.fromJson(json))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load slides');
    }
  }
}
