import 'package:eicapp/models/incentive.dart';
import 'package:eicapp/providers/incentive.dart';
import 'package:eicapp/screens/incentive.dart';
import 'package:eicapp/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncentiveListScreen extends StatefulWidget {
  static final String id = 'incentive_list_screen';
  @override
  State<StatefulWidget> createState() {
    return _IncentiveListScreenState();
  }
}

class _IncentiveListScreenState extends State<IncentiveListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<IncentiveProvider>(
          builder: (context, model, _) {
            return Text(
              model.selectedPackage,
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.title.fontFamily,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        centerTitle: true,
      ),
      // endDrawer: MyDrawer(),
      body: WillPopScope(
        child: SingleChildScrollView(
          child: Consumer<IncentiveProvider>(
            builder: (context, model, _) {
              if (model.selectedPackage == null) {
                return Center(child: CircularProgressIndicator());
              }

              var packageIncentives = model.selectedPackageIncentives();
              return Column(
                children: packageIncentives.map((incentive) {
                  return Card(
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      title: Text(
                        incentive.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(Icons.navigate_next),
                      onTap: () {
                        _selectIncentive(incentive);
                      },
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
        onWillPop: () {
          Provider.of<IncentiveProvider>(context, listen: false)
              .unselectPackage();
          return Future.value(true);
        },
      ),
    );
  }

  void _selectIncentive(Incentive incentive) {
    Provider.of<IncentiveProvider>(context, listen: false)
        .selectIncentive(incentive);
    Navigator.pushNamed(context, IncentiveScreen.id);
  }
}
