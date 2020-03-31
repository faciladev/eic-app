import 'package:eicapp/models/setting.dart';
import 'package:eicapp/providers/setting.dart';
import 'package:eicapp/screens/home.dart';
import 'package:eicapp/screens/language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BootstrapScreen extends StatefulWidget {
  static final String id = 'bootstrap_screen';
  @override
  _BootstrapScreenState createState() => _BootstrapScreenState();
}

class _BootstrapScreenState extends State<BootstrapScreen> {
  bool ready = false;
  // int todoTasks = 2;
  // int completedTasks = 0;
  @override
  void initState() {
    super.initState();
    onBoot();
  }

  // bool allComplete() => todoTasks == completedTasks;

  // void completeOneTask() {
  //   setState(() {
  //     completedTasks = completedTasks + 1;
  //     ready = allComplete();
  //   });
  // }

  void onBoot() async {
    if (Provider.of<SettingProvider>(context, listen: false).allSettings ==
        null) {
      await Provider.of<SettingProvider>(context, listen: false).loadSettings();
      // completeOneTask();
      setState(() {
        ready = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!ready) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Please wait...',
              style: Theme.of(context).textTheme.body1,
            ),
          ],
        ),
      );
    }
    return Consumer<SettingProvider>(
      builder: (context, model, _) {
        List<Setting> settings = model.allSettings;
        Widget page;

        if (settings != null &&
            settings.length > 0 &&
            settings.any((Setting setting) => setting.name == 'language')) {
          page = HomeScreen();
        } else {
          page = LanguageScreen();
        }
        return page;
      },
    );
  }
}
