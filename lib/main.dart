import 'package:eicapp/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eicapp/models/language.dart';
import 'package:eicapp/screens/language.dart';
import 'package:eicapp/screens/news.dart';

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
      title: 'EIC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LanguageScreen(),
        '/home': (context) => HomeScreen(),
        '/news': (context) => NewsScreen()
      },
    );
  }
}
