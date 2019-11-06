import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  static final String id = 'landing_screen';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: size.height,
              width: size.width,
              // color: Theme.of(context).primaryColor,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/background.jpg',
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                // alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                    // color: Color.fromRGBO(0, 0, 0, 0.7),
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      Card(
                        color: Color.fromRGBO(0, 0, 0, 0.4),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Welcome \nto Ethiopian Investment Commission',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .title
                                      .fontFamily,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Image.asset('assets/images/background2.jpg'),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
