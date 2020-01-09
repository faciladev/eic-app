import 'package:eicapp/models/country_profile.dart';
import 'package:eicapp/providers/country_profile.dart';
import 'package:eicapp/models/step.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class StepProvider extends ChangeNotifier {
  List<dynamic> allSteps;
  StepModel selectedStep;

  Future<void> fetchAllSteps(BuildContext context) async {
    if (Provider.of<CountryProfileProvider>(context, listen: false)
            .allCountryProfiles
            .length <=
        0) {
      await Provider.of<CountryProfileProvider>(context, listen: false)
          .fetchAllCountryProfiles();
    }

    List<dynamic> allCountryProfiles =
        Provider.of<CountryProfileProvider>(context, listen: false)
            .allCountryProfiles;

    if (allCountryProfiles.length > 0) {
      for (CountryProfile profile in allCountryProfiles) {
        if (profile.name == 'Get Started') {
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
          break;
        }
      }
    } else {
      throw Exception('Failed to load Step');
    }
  }

  void selectStep(StepModel step) => selectedStep = step;
  void unselectStep() => selectedStep = null;
}
