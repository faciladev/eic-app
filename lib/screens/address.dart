import 'package:eicapp/widgets/myappbar.dart';
import 'package:eicapp/widgets/page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddressScreen extends StatelessWidget {
  static final String id = 'address_screen';
  @override
  Widget build(BuildContext context) {
    return Page(
      appBar: MyAppBar(
        context,
        title: "Get in Touch",
      ),
      pageContent: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text('Addis Ababa, Ethiopia'),
                    Text('P.O. Box 2313'),
                    Text('Tel: +251 11 551 0033'),
                    Text('Fax: +251 11 551 4396'),
                    Text('Email: info@eic.gov.et'),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Divider(),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.twitter,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          '@EthioInvestment',
                          style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue[900],
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          '@InvestEthiopia',
                          style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
