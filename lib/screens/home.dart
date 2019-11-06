import 'package:eicapp/providers/language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eicapp/screens/news_list.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, model, child) {
        if (model.language == Language.English) {
          return NewsListScreen();
        } else {
          return Container();
        }
      },
    );
  }
}
