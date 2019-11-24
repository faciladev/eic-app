import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:eicapp/models/chinese_page.dart';

class ChinesePageProvider extends ChangeNotifier {
  List<dynamic> allChinesePages;
  ChinesePage selectedChinesePage;

  Future<void> fetchAllChinesePages() async {
    final response = await http.get('http://10.0.2.2:3000/ChinesePages');

    if (response.statusCode == 200) {
      allChinesePages = jsonDecode(utf8.decode(response.bodyBytes))
          .map((json) => ChinesePage.fromJson(json))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load country profile');
    }
  }

  void selectChinesePage(ChinesePage chinesePage) =>
      selectedChinesePage = chinesePage;
  void unselectChinesePage() => selectedChinesePage = null;
}
