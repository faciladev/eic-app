import 'dart:convert';

import 'package:eicapp/providers/config_profider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eicapp/models/incentive.dart';
import 'package:provider/provider.dart';

class IncentiveProvider extends ChangeNotifier {
  List<dynamic> allIncentives;
  Incentive selectedIncentive;
  String selectedPackage;
  List<String> _packages = [];

  final BuildContext context;

  IncentiveProvider({this.context});

  Future<void> fetchAllIncentives() async {
    String url =
        Provider.of<ConfigProvider>(context, listen: false).config.apiBase;
    final response = await http.get(url + 'incentives?format=json');
    if (response.statusCode == 200) {
      allIncentives = jsonDecode(response.body)
          .map((json) => Incentive.fromJson(json))
          .toList();
      allIncentives.forEach((incentive) {
        if (_packages.contains(incentive.incentivePackage)) {
          return;
        }

        _packages.add(incentive.incentivePackage);
      });

      notifyListeners();
    } else {
      throw Exception('Failed to load Incentive');
    }
  }

  List<String> get packages => _packages;
  List<dynamic> selectedPackageIncentives() {
    return allIncentives
        .where((incentive) => incentive.incentivePackage == selectedPackage)
        .toList();
  }

  void selectIncentive(Incentive incentive) => selectedIncentive = incentive;
  void selectPackage(String packageName) => selectedPackage = packageName;
  void unselectIncentive() => selectedIncentive = null;
  void unselectPackage() => selectedPackage = null;
}
