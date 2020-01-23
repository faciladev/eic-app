import 'package:eicapp/util/ui_builder.dart';
import 'package:eicapp/widgets/page.dart';
import 'package:flutter/material.dart';

class StackPage extends Page {
  final Widget drawer;
  final Shadow shadow;
  final PreferredSize appBar;
  final Widget pageContent;
  final DecorationImage image;
  final CustomClipper<Path> customClipper;
  final double pageContentOffsetPercent;

  StackPage(
      {this.drawer,
      this.shadow,
      this.customClipper,
      this.image,
      this.appBar,
      this.pageContent,
      this.pageContentOffsetPercent = 0,
      Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    PageImageHeader header = PageImageHeader(
        shadow: shadow, customClipper: customClipper, image: image);

    Stack myStack = Stack(
      children: <Widget>[
        header,
        CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  height: 300,
                ),
                Container(
                  child: pageContent,
                  height: MediaQuery.of(context).size.height,
                ),
              ]),
            )
          ],
        ),
      ],
    );
    return Page(
      appBar: appBar,
      pageContent: myStack,
      drawer: drawer,
    );
  }
}

class PageImageHeader extends StatelessWidget {
  final CustomClipper<Path> customClipper;
  final DecorationImage image;
  final Shadow shadow;

  PageImageHeader({this.shadow, this.customClipper, this.image, Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ClipShadowShadowPainter(
        clipper: customClipper,
        shadow: shadow,
      ),
      child: ClipPath(
          child: Container(
            decoration: BoxDecoration(
              image: image,
              // borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          clipper: customClipper),
    );
  }
}
