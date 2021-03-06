import 'package:eicapp/providers/chinese_page.dart';
import 'package:eicapp/providers/config_profider.dart';
import 'package:eicapp/providers/country_profile.dart';
import 'package:eicapp/providers/feedback.dart';
import 'package:eicapp/providers/incentive.dart';
import 'package:eicapp/providers/news.dart';
import 'package:eicapp/providers/sector.dart';
import 'package:eicapp/providers/service.dart';
import 'package:eicapp/providers/setting.dart';
import 'package:eicapp/providers/slider.dart';
import 'package:eicapp/screens/bootstrap.dart';
import 'package:eicapp/screens/chinese_page.dart';
import 'package:eicapp/screens/country_profile.dart';
import 'package:eicapp/screens/country_profile_list.dart';
import 'package:eicapp/screens/home.dart';
import 'package:eicapp/screens/incentive.dart';
import 'package:eicapp/screens/incentive_list.dart';
import 'package:eicapp/screens/incentive_package_list.dart';
import 'package:eicapp/screens/news.dart';
import 'package:eicapp/screens/sector.dart';
import 'package:eicapp/screens/sector_list.dart';
import 'package:eicapp/screens/service.dart';
import 'package:eicapp/screens/service_list.dart';
import 'package:eicapp/screens/setting.dart';
import 'package:eicapp/screens/setting_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eicapp/screens/language.dart';
import 'package:eicapp/screens/news_list.dart';
import 'package:eicapp/screens/feedback.dart';
import 'package:eicapp/env/dev.dart'; //exports config variable

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ConfigProvider(config: config),
          ),
          ChangeNotifierProvider(
            create: (context) => SlideProvider(context: context),
          ),
          ChangeNotifierProvider(
            create: (context) => NewsProvider(context: context),
          ),
          ChangeNotifierProvider(
            create: (context) => IncentiveProvider(context: context),
          ),
          ChangeNotifierProvider(
            create: (context) => SectorProvider(context: context),
          ),
          ChangeNotifierProvider(
            create: (context) => CountryProfileProvider(context: context),
          ),
          ChangeNotifierProvider(
            create: (context) => ServiceProvider(context: context),
          ),
          ChangeNotifierProvider(
            create: (context) => ChinesePageProvider(context: context),
          ),
          ChangeNotifierProvider(
            create: (context) => SettingProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FeedbackProvider(context: context),
          ),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EIC',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        primaryColor: _eicBlue(),
        accentColor: _eicGrey(),
        secondaryHeaderColor: _eicGreen(),
        textTheme: TextTheme(
          title: TextStyle(
            fontFamily: 'Optima',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          body1: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 18.0,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => BootstrapScreen(),
        BootstrapScreen.id: (context) => BootstrapScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        NewsListScreen.id: (context) => NewsListScreen(),
        FeedbackScreen.id: (context) => FeedbackScreen(),
        NewsScreen.id: (context) => NewsScreen(),
        IncentivePackageListScreen.id: (context) =>
            IncentivePackageListScreen(),
        IncentiveListScreen.id: (context) => IncentiveListScreen(),
        IncentiveScreen.id: (context) => IncentiveScreen(),
        SectorListScreen.id: (context) => SectorListScreen(),
        SectorScreen.id: (context) => SectorScreen(),
        CountryProfileListScreen.id: (context) => CountryProfileListScreen(),
        CountryProfileScreen.id: (context) => CountryProfileScreen(),
        ServiceScreen.id: (context) => ServiceScreen(),
        ServiceListScreen.id: (context) => ServiceListScreen(),
        ChinesePageScreen.id: (context) => ChinesePageScreen(),
        SettingListScreen.id: (context) => SettingListScreen(),
        SettingScreen.id: (context) => SettingScreen(),
        LanguageScreen.id: (context) => LanguageScreen(),
      },
    );
  }

  Color _eicBlue() => Color.fromRGBO(34, 70, 157, 1);
  Color _eicGrey() => Color.fromRGBO(167, 169, 172, 1);
  Color _eicGreen() => Color.fromRGBO(5, 138, 68, 1);
}
