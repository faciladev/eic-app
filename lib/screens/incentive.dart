import 'package:eicapp/providers/incentive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncentiveScreen extends StatefulWidget {
  static final String id = 'incentive_screen';
  @override
  State<StatefulWidget> createState() {
    return _IncentiveScreenState();
  }
}

class _IncentiveScreenState extends State<IncentiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {},
          )
        ],
      ),
      body: WillPopScope(
        child: SingleChildScrollView(
          child: Consumer<IncentiveProvider>(
            builder: (context, model, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildIncentiveEntry(
                      context, 'Incentive Name', model.selectedIncentive.name),
                  _buildIncentiveEntry(context, 'Description',
                      model.selectedIncentive.description),
                  _buildIncentiveEntry(context, 'Legal Reference',
                      model.selectedIncentive.legalReference),
                  _buildIncentiveEntry(context, 'Law Section',
                      model.selectedIncentive.lawSection),
                  _buildIncentiveEntry(
                      context, 'Sector', model.selectedIncentive.sector),
                  _buildIncentiveEntry(context, 'Eligebility',
                      model.selectedIncentive.eligebility),
                  _buildIncentiveEntry(context, 'Rewarding Authority',
                      model.selectedIncentive.rewardingAuthority),
                  _buildIncentiveEntry(context, 'Implementing Authority',
                      model.selectedIncentive.implementingAuthority),
                ],
              );
            },
          ),
        ),
        onWillPop: () {
          Provider.of<IncentiveProvider>(context, listen: false)
              .unselectIncentive();
          return Future.value(true);
        },
      ),
    );
  }

  Widget _buildIncentiveEntry(
      BuildContext context, String entryName, String entryValue) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                entryName,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                entryValue,
                style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.title.fontFamily,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
