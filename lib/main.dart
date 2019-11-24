import 'package:eicapp/providers/chinese_page.dart';
import 'package:eicapp/providers/country_profile.dart';
import 'package:eicapp/providers/incentive.dart';
import 'package:eicapp/providers/news.dart';
import 'package:eicapp/providers/sector.dart';
import 'package:eicapp/providers/service.dart';
import 'package:eicapp/providers/setting.dart';
import 'package:eicapp/screens/bootstrap.dart';
import 'package:eicapp/screens/chinese_page.dart';
import 'package:eicapp/screens/country_profile.dart';
import 'package:eicapp/screens/country_profile_list.dart';
import 'package:eicapp/screens/home.dart';
import 'package:eicapp/screens/incentive.dart';
import 'package:eicapp/screens/incentive_list.dart';
import 'package:eicapp/screens/incentive_package_list.dart';
import 'package:eicapp/screens/landing.dart';
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

void main() => runApp(
      MultiProvider(
        providers: [
          // ChangeNotifierProvider(
          //   builder: (context) => LanguageProvider(),
          // ),
          ChangeNotifierProvider(
            builder: (context) => NewsProvider(),
          ),
          ChangeNotifierProvider(
            builder: (context) => IncentiveProvider(),
          ),
          ChangeNotifierProvider(
            builder: (context) => SectorProvider(),
          ),
          ChangeNotifierProvider(
            builder: (context) => CountryProfileProvider(),
          ),
          ChangeNotifierProvider(
            builder: (context) => ServiceProvider(),
          ),
          ChangeNotifierProvider(
            builder: (context) => ChinesePageProvider(),
          ),
          ChangeNotifierProvider(
            builder: (context) => SettingProvider(),
          )
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
        textTheme: TextTheme(
          title: TextStyle(
            fontFamily: 'Optima',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
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
        LandingScreen.id: (context) => LandingScreen(),
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
}
