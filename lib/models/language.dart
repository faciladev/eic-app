import 'package:flutter/material.dart';

class LanguageModel extends ChangeNotifier {
  Language _language;

  void selectLanguage(Language language) {
    _language = language;
    notifyListeners();
  }

  Language get language => _language;
}

enum Language { English, Chinese }