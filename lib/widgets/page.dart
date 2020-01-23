import 'package:flutter/material.dart';

class Page extends StatelessWidget {
  final PreferredSize appBar;
  final Widget pageContent;
  final Widget drawer;
  final bool background;

  Page(
      {this.appBar,
      this.pageContent,
      this.drawer,
      this.background = true,
      Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        decoration: background
            ? BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background1.jpg'),
                  fit: BoxFit.cover,
                ),
              )
            : null,
        child: pageContent,
      ),
      drawer: drawer,
    );
  }
}
