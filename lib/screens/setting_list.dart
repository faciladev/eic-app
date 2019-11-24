// import 'package:eicapp/providers/language.dart';
import 'package:eicapp/providers/setting.dart';
import 'package:eicapp/screens/setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingListScreen extends StatelessWidget {
  static final String id = 'setting_list_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, model, _) {
        String title, language, label;
        if (model.language == Language.English) {
          title = 'Settings';
          language = 'English';
          label = 'Language';
        } else {
          title = '设置';
          language = '中文';
          label = '语言';
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              title,
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.title.fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: ListView(
            children: <Widget>[
              Card(
                child: InkWell(
                  splashColor: Theme.of(context).primaryColor,
                  onTap: () {
                    Navigator.pushNamed(context, SettingScreen.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          label,
                          style: Theme.of(context).textTheme.title,
                        )),
                        Text(
                          language,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 15.0),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).accentColor,
                          size: 17.0,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
