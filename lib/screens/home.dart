import 'package:eicapp/models/language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eicapp/screens/news.dart';

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
    return Consumer<LanguageModel>(
      builder: (context, model, child) {
        if (model.language == Language.English) {
          return NewsScreen();
        } else {
          return Container();
        }
      },
    );
  }
}
