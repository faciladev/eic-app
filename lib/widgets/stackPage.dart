import 'package:eicapp/widgets/page.dart';
import 'package:eicapp/widgets/pageImageHeader.dart';
import 'package:flutter/material.dart';

class StackPage extends Page {
  final PreferredSize appBar;
  final Widget pageContent;
  final DecorationImage image;
  final CustomClipper<Path> customClipper;
  final double pageContentOffsetPercent;

  StackPage(
      {this.customClipper,
      this.image,
      this.appBar,
      this.pageContent,
      this.pageContentOffsetPercent = 0,
      Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    PageImageHeader header =
        PageImageHeader(customClipper: customClipper, image: image);
    Stack myStack = Stack(
      children: <Widget>[
        header,
        Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height *
                  pageContentOffsetPercent),
          child: pageContent,
        ),
      ],
    );
    return Page(
      appBar: appBar,
      pageContent: myStack,
    );
  }
}
