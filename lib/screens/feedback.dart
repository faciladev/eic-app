import 'dart:async';

import 'package:eicapp/models/feedback.dart';
import 'package:eicapp/providers/config_profider.dart';
import 'package:eicapp/providers/feedback.dart';
import 'package:eicapp/widgets/myappbar.dart';
import 'package:eicapp/widgets/page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart' show canLaunch, launch;

class FeedbackScreen extends StatefulWidget {
  static final String id = 'feedback_screen';
  @override
  State<StatefulWidget> createState() {
    return _FeedbackScreenState();
  }
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email, _message, _subject;
  bool sent = false;
  bool sending = false;

  Future<void> _showSuccessAlert({suceess: true}) async {
    String title = suceess ? "Message was sent!" : "Message was not sent!";
    String body =
        suceess ? 'Thanks for your feedback.' : 'Please try again, later.';
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(body),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _submit() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        sending = true;
      });
      _formKey.currentState.save();
      FeedbackModel feedback =
          FeedbackModel(sender: _email, message: _message, subject: _subject);
      sent = await Provider.of<FeedbackProvider>(context, listen: false)
          .sendEmail(feedback);
      if (!sent) {
        _showSuccessAlert(suceess: false);
        setState(() {
          sending = false;
        });
      }
      _showSuccessAlert();
      _formKey.currentState.reset();
      setState(() {
        sending = false;
      });
    }
  }

  Widget buildSendButton(BuildContext context) {
    if (sending) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return FlatButton(
      padding: EdgeInsets.all(10.0),
      onPressed: _submit,
      color: Theme.of(context).secondaryHeaderColor,
      child: Text(
        'Send',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String twitterUrl = Provider.of<ConfigProvider>(context).config.twitterUrl;
    String facebookUrl =
        Provider.of<ConfigProvider>(context).config.facebookUrl;
    Widget addressContent = Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SelectableText('Addis Ababa, Ethiopia'),
                  SelectableText('P.O. Box 2313'),
                  SelectableText('Tel: +251 11 551 0033'),
                  SelectableText('Fax: +251 11 551 4396'),
                  Linkify(
                    onOpen: (link) async {
                      if (await canLaunch(link.url)) {
                        await launch(link.url);
                      } else {
                        throw 'Could not launch $link';
                      }
                    },
                    text: 'Email: info@ethio-invest.com',
                  ),
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
                      Linkify(
                        onOpen: (link) async {
                          if (await canLaunch(twitterUrl)) {
                            await launch(twitterUrl);
                          } else {
                            throw 'Could not launch $twitterUrl';
                          }
                        },
                        text: twitterUrl,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
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
                      Linkify(
                        onOpen: (link) async {
                          if (await canLaunch(facebookUrl)) {
                            await launch(facebookUrl);
                          } else {
                            throw 'Could not launch $facebookUrl';
                          }
                        },
                        text: facebookUrl,
                        linkStyle: TextStyle(
                          color: Colors.blue[900],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
    Widget pageContent = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildTextField(
                labelText: "Your Email",
                keyboardType: TextInputType.emailAddress,
                validator: (input) =>
                    !input.contains('@') ? 'Please enter a valid email' : null,
                onSaved: (input) => _email = input,
              ),
              _buildTextField(
                labelText: "Subject",
                validator: (input) => input.trim().isEmpty
                    ? 'Please enter feedback subject'
                    : null,
                onSaved: (input) => _subject = input,
              ),
              _buildTextField(
                labelText: "Message",
                validator: (input) =>
                    input.trim().isEmpty ? 'Please enter your feedback' : null,
                onSaved: (input) => _message = input,
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: 250.0,
                child: buildSendButton(context),
              ),
            ],
          ),
        )
      ],
    );

    return Page(
      appBar: MyAppBar(
        context,
        title: "Contact",
      ),
      pageContent: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            addressContent,
            SizedBox(
              height: 20.0,
            ),
            pageContent
          ],
        ),
      ),
    );
  }

  Padding _buildTextField({
    String labelText,
    TextInputType keyboardType,
    Function validator,
    Function onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: labelText),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
