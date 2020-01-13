import 'package:eicapp/providers/chinese_page.dart';
import 'package:eicapp/providers/setting.dart';
import 'package:eicapp/widgets/myappbar.dart';
// import 'package:eicapp/providers/language.dart';
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
        label = 'Select 语言';
      }

      return Scaffold(
          appBar: MyAppBar(
            context,
            title: label,
          ),
          body: ListView(children: <Widget>[
            Column(
              children: <Widget>[
                _buildLanguageItem(context, model, Language.English),
                _buildLanguageItem(context, model, Language.Chinese),
              ],
            ),
          ]));
    });
  }

  Card _buildLanguageItem(
      BuildContext context, SettingProvider model, Language language) {
    return Card(
      child: InkWell(
        splashColor: Theme.of(context).primaryColor,
        onTap: () {
          if (Provider.of<SettingProvider>(context, listen: false).language !=
              language) {
            if (language == Language.Chinese) {
              Provider.of<ChinesePageProvider>(context).fetchAllChinesePages();
            }
            Provider.of<SettingProvider>(context).selectLanguage(language);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(
                  language == Language.English ? 'English' : '中文',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              model.language == language
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).primaryColor,
                      size: 20.0,
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
