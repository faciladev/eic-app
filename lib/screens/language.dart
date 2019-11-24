import 'package:eicapp/providers/chinese_page.dart';
import 'package:eicapp/providers/setting.dart';
// import 'package:eicapp/providers/language.dart';
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
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              height: 17,
            ),
            Text(
              'Select Language | 语',
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: Theme.of(context).textTheme.title.fontFamily),
            ),
            Divider(
              height: 30.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: <Widget>[
                  _buildLanguageOption(Language.English),
                  Divider(),
                  _buildLanguageOption(Language.Chinese),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildLanguageOption(Language language) {
    return Consumer<SettingProvider>(builder: (context, model, _) {
      String _countryCode, _languageTitle;
      if (language == Language.Chinese) {
        _countryCode = 'cn';
        _languageTitle = '中文';
      } else if (language == Language.English) {
        _countryCode = 'gb';
        _languageTitle = 'English';
      }
      return GestureDetector(
        child: Container(
          decoration: BoxDecoration(color: Theme.of(context).accentColor),
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildCountryImage(country: _countryCode, width: 50.0),
              Text(
                _languageTitle,
                style: Theme.of(context).textTheme.title,
              ),
              Icon(Icons.navigate_next),
            ],
          ),
        ),
        onTap: () => _languageHandler(context, model, language),
      );
    });
  }

  Image _buildCountryImage({String country, double width}) {
    return Image.asset(
      'icons/flags/png/$country.png',
      package: 'country_icons',
      width: width,
    );
  }

  void _languageHandler(context, SettingProvider model, Language language) {
    if (language == Language.Chinese) {
      Provider.of<ChinesePageProvider>(context).fetchAllChinesePages();
    }
    model.selectLanguage(language);
    Navigator.pushReplacementNamed(context, HomeScreen.id);
  }
}
