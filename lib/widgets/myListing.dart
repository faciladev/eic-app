import 'package:flutter/material.dart';

class MyListing extends StatelessWidget {
  final Function myOnTap;
  final List<Widget> widgets;
  const MyListing(this.widgets, {Key key, this.myOnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      onTap: myOnTap != null ? myOnTap : () {},
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.4, 0.8],
            colors: <Color>[
              Theme.of(context).primaryColor,
              Theme.of(context).secondaryHeaderColor
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widgets,
        ),
      ),
    );
  }
}
