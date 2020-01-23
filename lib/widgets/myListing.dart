import 'package:flutter/material.dart';

class MyListing extends StatelessWidget {
  final Function myOnTap;
  final List<Widget> widgets;
  final bool shouldGradient;
  const MyListing(
    this.widgets, {
    Key key,
    this.myOnTap,
    this.shouldGradient = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        onTap: myOnTap != null ? myOnTap : () {},
        child: Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 3)],
              color: shouldGradient
                  ? null
                  : Theme.of(context).secondaryHeaderColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              gradient: shouldGradient
                  ? LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.1, 0.9],
                      colors: <Color>[
                        Theme.of(context).primaryColor,
                        Theme.of(context).secondaryHeaderColor
                      ],
                    )
                  : null),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widgets,
          ),
        ),
      ),
    );
  }
}
