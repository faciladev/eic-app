import 'package:flutter/material.dart';

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
  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text(
          'Contact',
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.title.fontFamily,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(30),
                    color: Theme.of(context).accentColor,
                    child: DefaultTextStyle(
                      child: Column(
                        children: <Widget>[
                          Text('Addis Ababa, Ethiopia'),
                          Text('P.O. Box 2313'),
                          Text('Tel: +251 11 551 0033'),
                          Text('Fax: +251 11 551 4396'),
                          Text('Email: info@eic.gov.et'),
                        ],
                      ),
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (input) => !input.contains('@')
                            ? 'Please enter a valid email'
                            : null,
                        onSaved: (input) => _email = input,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Subject'),
                        validator: (input) => input.trim().isEmpty
                            ? 'Please enter feedback subject'
                            : null,
                        onSaved: (input) => _subject = input,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        decoration: InputDecoration(labelText: 'Message'),
                        validator: (input) => input.trim().isEmpty
                            ? 'Please enter your feedback'
                            : null,
                        onSaved: (input) => _message = input,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: 250.0,
                      child: FlatButton(
                        padding: EdgeInsets.all(10.0),
                        onPressed: _submit,
                        color: Theme.of(context).accentColor,
                        child: Text(
                          'Send',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
