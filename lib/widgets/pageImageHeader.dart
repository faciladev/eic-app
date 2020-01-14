import 'package:flutter/material.dart';

class PageImageHeader extends StatelessWidget {
  final CustomClipper<Path> customClipper;
  final DecorationImage image;

  PageImageHeader({this.customClipper, this.image, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipBehavior: Clip.hardEdge,
      clipper: customClipper,
      child: Container(
        decoration: BoxDecoration(image: image),
      ),
    );
  }
}
