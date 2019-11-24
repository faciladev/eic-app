import 'package:eicapp/models/setting.dart';
import 'package:eicapp/providers/setting.dart';
import 'package:eicapp/screens/home.dart';
import 'package:eicapp/screens/language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

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
    }
  }

  @override
  Widget build(BuildContext context) {
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
        return SplashScreen(
          seconds: 1,
          navigateAfterSeconds: page,
          title:
              Text('Welcome to EIC', style: Theme.of(context).textTheme.title),
          image: Image.asset('assets/images/logo.jpg'),
          // backgroundGradient: LinearGradient(
          //     colors: [Colors.cyan, Colors.blue],
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight),
          backgroundColor: Colors.white,
          // gradientBackground: LinearGradient(
          //     colors: [Colors.cyan, Colors.blue],
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight),
          styleTextUnderTheLoader: TextStyle(),
          photoSize: 200.0,
          loadingText: Text('preparing your app'),
          onClick: () {},
          loaderColor: Colors.red,
        );
      },
    );
  }
}
