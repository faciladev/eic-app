import 'package:eicapp/models/country_profile.dart';
import 'package:eicapp/providers/country_profile.dart';
import 'package:eicapp/models/opportunity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class OpportunityProvider extends ChangeNotifier {
  List<dynamic> allOpportunities;
  Opportunity selectedOpportunity;

  Future<void> fetchAllOpportunities(BuildContext context) async {
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
          break;
        }
      }
    } else {
      throw Exception('Failed to load opportunity');
    }
  }

  void selectOpportunity(Opportunity opportunity) =>
      selectedOpportunity = opportunity;
  void unselectOpportunity() => selectedOpportunity = null;
}
