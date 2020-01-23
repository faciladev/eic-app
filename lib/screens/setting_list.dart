import 'package:eicapp/providers/setting.dart';
import 'package:eicapp/screens/setting.dart';
import 'package:eicapp/widgets/myListing.dart';
import 'package:eicapp/widgets/myappbar.dart';
import 'package:eicapp/widgets/page.dart';
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

        return Page(
          appBar: MyAppBar(
            context,
            title: title,
          ),
          pageContent: ListView(
            children: <Widget>[
              MyListing(
                [
                  Expanded(
                      child: Text(
                    label,
                    style: TextStyle(color: Colors.white),
                  )),
                  Text(
                    language,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 17.0,
                  )
                ],
                myOnTap: () {
                  Navigator.pushNamed(context, SettingScreen.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
