import 'dart:convert';

import 'package:eicapp/models/service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ServiceProvider extends ChangeNotifier {
  List<dynamic> allServices;
  Service selectedService;

  Future<void> fetchAllServices() async {
    final response = await http.get(
        'http://ec2-18-191-74-44.us-east-2.compute.amazonaws.com:3000/services');

    if (response.statusCode == 200) {
      allServices = jsonDecode(response.body)
          .map((json) => Service.fromJson(json))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load service');
    }
  }

  void selectService(Service service) => selectedService = service;
  void unselectService() => selectedService = null;
}
