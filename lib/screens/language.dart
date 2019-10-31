import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eicapp/models/language.dart';

class LanguageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LanguageScreenState();
  }
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language | 语'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<LanguageModel>(builder: (context, model, child) {
              return FlatButton(
                child: Text(
                  'English',
                ),
                onPressed: () => _languageHandler(context, model, Language.English),
              );
            }),
            Consumer<LanguageModel>(builder: (context, model, child) {
              return FlatButton(
                child: Text(
                  '中文',
                ),
                onPressed: () => _languageHandler(context, model, Language.Chinese),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _languageHandler(context, model, Language language) {
    model.selectLanguage(language);
    Navigator.pushNamed(context, '/home');
  }
}
