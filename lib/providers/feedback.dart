import 'dart:async';
import 'dart:convert';

import 'package:eicapp/models/feedback.dart';
import 'package:eicapp/providers/config_profider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class FeedbackProvider extends ChangeNotifier {
  final BuildContext context;

  FeedbackProvider({this.context});

  bool sent = false;
  Future<bool> sendEmail(FeedbackModel feedback) async {
    String url =
        Provider.of<ConfigProvider>(context, listen: false).config.apiBase;
    try {
      final response = await http.post(
        url + 'emails/',
        headers: {
          'Accept': 'application/json',
          'content-type': 'application/json'
        },
        body: jsonEncode(feedback.toMap()),
      );

      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      throw Exception('Failed to send email');
    }
  }
}
