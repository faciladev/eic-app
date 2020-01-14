import 'package:flutter/material.dart';

class Page extends StatelessWidget {
  final PreferredSize appBar;
  final Widget pageContent;

  Page({this.appBar, this.pageContent, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: pageContent,
    );
  }
}
