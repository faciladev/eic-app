import 'package:eicapp/screens/home.dart';
import 'package:eicapp/screens/landing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eicapp/models/language.dart';
import 'package:eicapp/screens/language.dart';
import 'package:eicapp/screens/news.dart';
import 'package:eicapp/screens/feedback.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            builder: (context) => LanguageModel(),
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
        NewsScreen.id: (context) => NewsScreen(),
        // '/feedback': (context) => FeedbackScreen(),
        FeedbackScreen.id: (context) => FeedbackScreen(),
        LandingScreen.id: (context) => LandingScreen(),
      },
    );
  }

  Color _eicBlue() => Color.fromRGBO(34, 70, 157, 1);
  Color _eicGrey() => Color.fromRGBO(167, 169, 172, 1);
}
