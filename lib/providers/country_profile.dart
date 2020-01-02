import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:eicapp/models/country_profile.dart';

class CountryProfileProvider extends ChangeNotifier {
  List<dynamic> allCountryProfiles;
  CountryProfile selectedCountryProfile;

  Future<void> fetchAllCountryProfiles() async {
    // final response = await http.get(
    //     'http://ec2-18-191-74-44.us-east-2.compute.amazonaws.com:3000/country-profiles');
    final response = await http.get('http://10.0.2.2:3000/country-profiles');
    if (response.statusCode == 200) {
      allCountryProfiles = jsonDecode(response.body)
          .map((json) => CountryProfile.fromJson(json))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load country profile');
    }
  }

  void selectCountryProfile(CountryProfile countryProfile) =>
      selectedCountryProfile = countryProfile;
  void unselectCountryProfile() => selectedCountryProfile = null;
}
