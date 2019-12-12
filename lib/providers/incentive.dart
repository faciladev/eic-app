import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:eicapp/models/incentive.dart';

class IncentiveProvider extends ChangeNotifier {
  List<dynamic> allIncentives;
  Incentive selectedIncentive;
  String selectedPackage;
  List<String> _packages = [];

  Future<void> fetchAllIncentives() async {
    final response = await http.get(
        'http://ec2-18-191-74-44.us-east-2.compute.amazonaws.com:3000/incentives');

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
