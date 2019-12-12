import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:eicapp/models/sector.dart';

class SectorProvider extends ChangeNotifier {
  List<dynamic> allSectors;
  Sector selectedSector;

  Future<void> fetchAllSectors() async {
    final response = await http.get(
        'http://ec2-18-191-74-44.us-east-2.compute.amazonaws.com:3000/sectors');

    if (response.statusCode == 200) {
      allSectors = jsonDecode(response.body)
          .map((json) => Sector.fromJson(json))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load Sector');
    }
  }

  void selectSector(Sector sector) => selectedSector = sector;
  void unselectSector() => selectedSector = null;
}
