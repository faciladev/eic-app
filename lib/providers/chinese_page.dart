import 'dart:convert';

import 'package:eicapp/providers/config_profider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:eicapp/models/chinese_page.dart';
import 'package:provider/provider.dart';

class ChinesePageProvider extends ChangeNotifier {
  List<dynamic> allChinesePages;
  ChinesePage selectedChinesePage;

  final BuildContext context;

  ChinesePageProvider({this.context});

  Future<void> fetchAllChinesePages() async {
    String url =
        Provider.of<ConfigProvider>(context, listen: false).config.apiBase;
    final response = await http.get(url + 'chinesepages?format=json');

    if (response.statusCode == 200) {
      allChinesePages = jsonDecode(utf8.decode(response.bodyBytes))
          .map((json) => ChinesePage.fromJson(json))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load country profile');
    }
  }

  void selectPageByAttributes(Map<String, dynamic> attributes) async {
    if (allChinesePages == null) {
      await fetchAllChinesePages();
    }

    selectedChinesePage = allChinesePages.singleWhere((page) {
      return attributes.keys.every((key) {
        Map<String, dynamic> resource = page.toMap();
        return resource[key] == attributes[key];
      });
    }, orElse: () => null);
  }

  void selectChinesePage(ChinesePage chinesePage) =>
      selectedChinesePage = chinesePage;
  void unselectChinesePage() => selectedChinesePage = null;
}
