import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  static final String id = 'landing_screen';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/background.jpg',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
