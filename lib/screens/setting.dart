import 'package:eicapp/providers/chinese_page.dart';
import 'package:eicapp/providers/setting.dart';
import 'package:eicapp/widgets/myListing.dart';
import 'package:eicapp/widgets/myappbar.dart';
import 'package:eicapp/widgets/page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  static final String id = 'setting_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (context, model, _) {
      String label;
      if (model.language == Language.English) {
        label = 'Select Language';
      } else {
        label = '语言';
      }

      return Page(
        appBar: MyAppBar(
          context,
          title: label,
        ),
        pageContent: ListView(children: <Widget>[
          Column(
            children: <Widget>[
              MyListing(
                _buildLanguageItem(context, model, Language.English),
                myOnTap: _myOnTap(
                  context,
                  Language.English,
                ),
              ),
              MyListing(
                _buildLanguageItem(context, model, Language.Chinese),
                myOnTap: _myOnTap(
                  context,
                  Language.Chinese,
                ),
              ),
            ],
          ),
        ]),
      );
    });
  }

  Function _myOnTap(BuildContext context, Language language) {
    return () {
      if (Provider.of<SettingProvider>(context, listen: false).language !=
          language) {
        if (language == Language.Chinese) {
          Provider.of<ChinesePageProvider>(context).fetchAllChinesePages();
        }
        Provider.of<SettingProvider>(context).selectLanguage(language);
      }
    };
  }

  List<Widget> _buildLanguageItem(
      BuildContext context, SettingProvider model, Language language) {
    return [
      Expanded(
        child: Text(
          language == Language.English ? 'English' : '中文',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      model.language == language
          ? Icon(
              Icons.check_circle_outline,
              color: Colors.white,
              size: 20.0,
            )
          : Container()
    ];
  }
}
