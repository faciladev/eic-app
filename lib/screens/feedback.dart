import 'dart:async';

import 'package:eicapp/models/feedback.dart';
import 'package:eicapp/providers/feedback.dart';
import 'package:eicapp/screens/address.dart';
import 'package:eicapp/util/ui_builder.dart';
import 'package:eicapp/widgets/myappbar.dart';
import 'package:eicapp/widgets/page.dart';
import 'package:eicapp/widgets/stackPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  void _submit() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        sending = true;
      });
      _formKey.currentState.save();
      FeedbackModel feedback =
          FeedbackModel(from: _email, message: _message, subject: _subject);
      sent = await Provider.of<FeedbackProvider>(context, listen: false)
          .sendEmail(feedback);
      if (sent) {
        _formKey.currentState.reset();
        Timer(Duration(seconds: 1), () {
          setState(() {
            sent = true;
          });
        });
      }
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
    Widget pageContent = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildTextField(
                labelText: "Email",
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

    return StackPage(
      appBar: MyAppBar(
        context,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.pushNamed(context, AddressScreen.id);
            },
          )
        ],
        title: "Contact",
      ),
      customClipper: MyPathClipper(height1: 0.30, height2: 0.40),
      shadow: Shadow(blurRadius: 5),
      image: DecorationImage(
        image: AssetImage('assets/images/background3.jpg'),
        fit: BoxFit.cover,
      ),
      pageContent: pageContent,
      pageContentOffsetPercent: 0.35,
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
