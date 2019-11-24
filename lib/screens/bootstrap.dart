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
  @override
  void initState() {
    super.initState();
    onBoot();
  }

  void onBoot() async {
    if (Provider.of<SettingProvider>(context, listen: false).allSettings ==
        null) {
      await Provider.of<SettingProvider>(context, listen: false).loadSettings();
      List<Setting> settings =
          Provider.of<SettingProvider>(context, listen: false).allSettings;

      if (settings != null &&
          settings.length > 0 &&
          settings.any((Setting setting) => setting.name == 'language')) {
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      } else {
        Navigator.pushReplacementNamed(context, LanguageScreen.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/logo.png'),
              fit: BoxFit.fitWidth,
            ),
            color: Theme.of(context).primaryColor),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
