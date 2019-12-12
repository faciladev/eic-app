import 'dart:async';
import 'dart:convert';

import 'package:eicapp/models/feedback.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeedbackProvider extends ChangeNotifier {
  bool sent = false;
  Future<bool> sendEmail(FeedbackModel feedback) async {
    final response = await http.post(
      'http://ec2-18-191-74-44.us-east-2.compute.amazonaws.com:3000/feedback',
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json'
      },
      body: jsonEncode(feedback.toMap()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to send email');
    }
  }
}
