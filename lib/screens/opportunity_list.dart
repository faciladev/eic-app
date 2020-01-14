// import 'package:eicapp/models/country_profile.dart';
import 'package:eicapp/models/opportunity.dart';
import 'package:eicapp/providers/country_profile.dart';
// import 'package:eicapp/providers/opportunity.dart';
import 'package:eicapp/screens/opportunity.dart';
import 'package:eicapp/widgets/myListing.dart';
import 'package:eicapp/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OpportunityListScreen extends StatefulWidget {
  static final String id = 'opportunity_list_screen';
  @override
  State<StatefulWidget> createState() {
    return _OpportunityListScreenState();
  }
}

class _OpportunityListScreenState extends State<OpportunityListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CountryProfileProvider>(context, listen: false)
        .fetchAllCountryProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context,
        title: "Opportunities",
      ),
      body: RefreshIndicator(
        child: _buildOpportunities(),
        onRefresh: () {
          return Provider.of<CountryProfileProvider>(context, listen: false)
              .fetchAllCountryProfiles();
        },
      ),
    );
  }

  Widget _buildOpportunities() {
    return Consumer<CountryProfileProvider>(
      builder: (context, opportunity, child) {
        if (opportunity.allOpportunities == null) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return MyListing(
              [
                Flexible(
                  child: Text(
                    opportunity.allOpportunities[index].name,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
              myOnTap: () =>
                  _selectOpportunity(opportunity.allOpportunities[index]),
            );
          },
          itemCount: opportunity.allOpportunities.length,
        );
      },
    );
  }

  void _selectOpportunity(Opportunity opportunity) {
    Provider.of<CountryProfileProvider>(context, listen: false)
        .selectOpportunity(opportunity);
    Navigator.pushNamed(context, OpportunityScreen.id);
  }
}
