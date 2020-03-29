import 'dart:convert';

import 'package:eicapp/providers/config_profider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eicapp/models/sector.dart';
import 'package:provider/provider.dart';

class SectorProvider extends ChangeNotifier {
  List<dynamic> allSectors;
  Sector selectedSector;
  final BuildContext context;

  SectorProvider({this.context});

  Future<void> fetchAllSectors() async {
    String url =
        Provider.of<ConfigProvider>(context, listen: false).config.apiBase;
    final response = await http.get(url + 'sectors?format=json');

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
