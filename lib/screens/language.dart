import 'package:eicapp/screens/landing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eicapp/models/language.dart';

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
                  Consumer<LanguageModel>(builder: (context, model, child) {
                    return GestureDetector(
                      child: Container(
                        decoration:
                            BoxDecoration(color: Theme.of(context).accentColor),
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _buildCountryImage(country: 'gb', width: 50.0),
                            Text(
                              'English',
                              style: Theme.of(context).textTheme.title,
                            ),
                            Icon(Icons.navigate_next),
                          ],
                        ),
                      ),
                      onTap: () =>
                          _languageHandler(context, model, Language.Chinese),
                    );
                  }),
                  Divider(),
                  Consumer<LanguageModel>(builder: (context, model, child) {
                    return GestureDetector(
                      child: Container(
                        decoration:
                            BoxDecoration(color: Theme.of(context).accentColor),
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _buildCountryImage(country: 'cn', width: 50.0),
                            Text(
                              '中文',
                              style: Theme.of(context).textTheme.title,
                            ),
                            Icon(Icons.navigate_next),
                          ],
                        ),
                      ),
                      onTap: () =>
                          _languageHandler(context, model, Language.Chinese),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Image _buildCountryImage({String country, double width}) {
    return Image.asset(
      'icons/flags/png/$country.png',
      package: 'country_icons',
      width: width,
    );
  }

  void _languageHandler(context, model, Language language) {
    model.selectLanguage(language);
    Navigator.pushNamed(context, LandingScreen.id);
  }
}
