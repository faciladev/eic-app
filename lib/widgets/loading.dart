import 'package:eicapp/widgets/page.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final bool isPage;

  Loading({this.isPage});

  @override
  Widget build(BuildContext context) {
    return isPage
        ? Page(
            pageContent: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
