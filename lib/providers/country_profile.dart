import 'dart:convert';

import 'package:eicapp/models/opportunity.dart';
import 'package:eicapp/models/step.dart';
import 'package:eicapp/providers/config_profider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:eicapp/models/country_profile.dart';
import 'package:provider/provider.dart';

class CountryProfileProvider extends ChangeNotifier {
  List<dynamic> allCountryProfiles;
  CountryProfile selectedCountryProfile;

  List<dynamic> allOpportunities;
  Opportunity selectedOpportunity;

  List<dynamic> allSteps;
  StepModel selectedStep;

  final BuildContext context;

  CountryProfileProvider({this.context});

  Future<void> fetchAllCountryProfiles() async {
    String url =
        Provider.of<ConfigProvider>(context, listen: false).config.apiBase;

    if (allCountryProfiles != null) return;
    final response = await http.get(url + 'country-profiles?format=json');
    if (response.statusCode == 200) {
      allCountryProfiles = json
          .decode(utf8.decode(response.bodyBytes))
          .map((json) => CountryProfile.fromJson(json))
          .toList();

      //Initialize Opportunities and Steps
      for (CountryProfile profile in allCountryProfiles) {
        if (profile.name == 'Growth Sectors and Opportunities') {
          Map<String, dynamic> content = profile.content;
          List<Opportunity> opportunities = [];
          List<String> opportunityNames = [
            'Manufacturing',
            'Agriculture',
            'Tourism',
            'Textile',
            'Leather',
            'Pharmaceuticals',
            'Agro-processing',
            'Big multinational'
          ];

          for (String title in content.keys) {
            for (String name in opportunityNames) {
              if (title.indexOf(name) >= 0) {
                opportunities
                    .add(Opportunity(name: title, content: content[title]));
              }
            }
          }

          allOpportunities = opportunities;
        } else if (profile.name == 'Get Started') {
          Map<String, dynamic> content = profile.content;
          List<StepModel> steps = [];
          List<String> stepNames = [
            'Register your Business',
            'Sole Proprietorship',
            'Private Limited Company',
            'Branch of a Multinational Company'
          ];

          for (String title in content.keys) {
            for (String name in stepNames) {
              if (title.indexOf(name) >= 0) {
                steps.add(StepModel(name: title, content: content[title]));
              }
            }
          }

          allSteps = steps;
        } else {
          continue;
        }
      }

      notifyListeners();
    } else {
      throw Exception('Failed to load country profile');
    }
  }

  void selectCountryProfile(CountryProfile countryProfile) =>
      selectedCountryProfile = countryProfile;

  void selectCountryProfileByName(String profileName) async {
    if (allCountryProfiles == null) {
      await fetchAllCountryProfiles();
    }

    if (allCountryProfiles != null) {
      try {
        selectedCountryProfile = allCountryProfiles.singleWhere((profile) {
          return profile.name == profileName;
        }) as CountryProfile;
      } catch (e) {
        print(e);
      }
    }
  }

  void unselectCountryProfile() => selectedCountryProfile = null;

  void selectOpportunity(Opportunity opportunity) =>
      selectedOpportunity = opportunity;
  void unselectOpportunity() => selectedOpportunity = null;

  void selectStep(StepModel step) => selectedStep = step;
  void unselectStep() => selectedStep = null;
}
