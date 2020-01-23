import 'package:flutter/material.dart';

class MyAppBar extends PreferredSize {
  MyAppBar(BuildContext context,
      {Key key, String title, double height = 50.0, List<Widget> actions})
      : super(
          key: key,
          preferredSize: Size.fromHeight(height),
          child: AppBar(
            actions: actions,
            title: Text(
              title != null ? title.toUpperCase() : "",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 17,
                // fontFamily: Theme.of(context).textTheme.title.fontFamily,
                fontWeight: FontWeight.bold,
                // style: TextStyle(
                //   fontFamily: Theme.of(context).textTheme.body1.fontFamily,
                // ),
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
