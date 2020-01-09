import 'package:eicapp/models/country_profile.dart';
import 'package:eicapp/models/opportunity.dart';
import 'package:eicapp/providers/opportunity.dart';
import 'package:eicapp/screens/opportunity.dart';
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
    Provider.of<OpportunityProvider>(context, listen: false)
        .fetchAllOpportunities(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Opportunities',
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.title.fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        child: _buildOpportunities(),
        onRefresh: () {
          return Provider.of<OpportunityProvider>(context, listen: false)
              .fetchAllOpportunities(context);
        },
      ),
    );
  }

  Widget _buildOpportunities() {
    return Consumer<OpportunityProvider>(
      builder: (context, opportunity, child) {
        if (opportunity.allOpportunities == null) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                title: Text(
                  opportunity.allOpportunities[index].name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(Icons.navigate_next),
                onTap: () =>
                    _selectOpportunity(opportunity.allOpportunities[index]),
              ),
            );
          },
          itemCount: opportunity.allOpportunities.length,
        );
      },
    );
  }

  void _selectOpportunity(Opportunity opportunity) {
    Provider.of<OpportunityProvider>(context, listen: false)
        .selectOpportunity(opportunity);
    Navigator.pushNamed(context, OpportunityScreen.id);
  }
}
