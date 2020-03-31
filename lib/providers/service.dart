import 'dart:convert';

import 'package:eicapp/models/service.dart';
import 'package:eicapp/providers/config_profider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ServiceProvider extends ChangeNotifier {
  List<dynamic> allServices;
  Service selectedService;
  final BuildContext context;

  ServiceProvider({this.context});

  Future<void> fetchAllServices() async {
    String url =
        Provider.of<ConfigProvider>(context, listen: false).config.apiBase;
    final response = await http.get(url + 'services?format=json');

    if (response.statusCode == 200) {
      allServices = jsonDecode(response.body)
          .map((json) => Service.fromJson(json))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load service');
    }
  }

  void selectServiceByAttributes(Map<String, dynamic> attributes) async {
    if (allServices == null) {
      await fetchAllServices();
    }

    selectedService = allServices.singleWhere((service) {
      return attributes.keys.every((key) {
        Map<String, dynamic> resource = service.toMap();
        return resource[key] == attributes[key];
      });
    }, orElse: () => null);
  }

  void selectService(Service service) => selectedService = service;
  void unselectService() => selectedService = null;
}
