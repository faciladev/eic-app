import 'package:flutter/material.dart';

class MyAppBar extends PreferredSize {
  MyAppBar(BuildContext context, {Key key, String title})
      : super(
          key: key,
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            title: Text(
              title != null ? title.toUpperCase() : "",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            iconTheme: IconThemeData(
              color: Theme.of(context).accentIconTheme.color,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
        );
}
