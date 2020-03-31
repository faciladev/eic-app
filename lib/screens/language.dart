import 'package:eicapp/providers/chinese_page.dart';
import 'package:eicapp/providers/setting.dart';
import 'package:eicapp/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  static final String id = 'language_screen';

  @override
  State<StatefulWidget> createState() {
    return _LanguageScreenState();
  }
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/language_clearsky.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[Colors.transparent, Colors.white30],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildLanguageOption(Language.English),
                  Text('|'),
                  _buildLanguageOption(Language.Chinese),
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }

  _buildLanguageOption(Language language) {
    return Consumer<SettingProvider>(builder: (context, model, _) {
      String _languageTitle;
      if (language == Language.Chinese) {
        _languageTitle = '中文';
      } else if (language == Language.English) {
        _languageTitle = 'ENG';
      }
      return GestureDetector(
        child: Container(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            _languageTitle,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
        )),
        onTap: () => _languageHandler(context, model, language),
      );
    });
  }

  void _languageHandler(context, SettingProvider model, Language language) {
    if (language == Language.Chinese) {
      Provider.of<ChinesePageProvider>(context).fetchAllChinesePages();
    }
    model.selectLanguage(language);
    Navigator.pushReplacementNamed(context, HomeScreen.id);
  }
}
