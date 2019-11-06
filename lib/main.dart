import 'package:eicapp/providers/language.dart';
import 'package:eicapp/providers/news.dart';
import 'package:eicapp/screens/home.dart';
import 'package:eicapp/screens/landing.dart';
import 'package:eicapp/screens/news.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eicapp/screens/language.dart';
import 'package:eicapp/screens/news_list.dart';
import 'package:eicapp/screens/feedback.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            builder: (context) => LanguageProvider(),
          ),
          ChangeNotifierProvider(
            builder: (context) => NewsProvider(),
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
        '/': (context) => LanguageScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        NewsListScreen.id: (context) => NewsListScreen(),
        FeedbackScreen.id: (context) => FeedbackScreen(),
        LandingScreen.id: (context) => LandingScreen(),
        NewsScreen.id: (context) => NewsScreen(),
      },
    );
  }

  Color _eicBlue() => Color.fromRGBO(34, 70, 157, 1);
  Color _eicGrey() => Color.fromRGBO(167, 169, 172, 1);
}
