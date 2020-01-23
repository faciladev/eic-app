import 'package:eicapp/models/incentive.dart';
import 'package:eicapp/providers/incentive.dart';
import 'package:eicapp/screens/incentive.dart';
import 'package:eicapp/util/ui_builder.dart';
import 'package:eicapp/widgets/drawer.dart';
import 'package:eicapp/widgets/myListing.dart';
import 'package:eicapp/widgets/myappbar.dart';
import 'package:eicapp/widgets/page.dart';
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
    String title = Provider.of<IncentiveProvider>(context).selectedPackage;

    return Page(
      appBar: MyAppBar(
        context,
        title: title,
      ),
      pageContent: WillPopScope(
        child: Consumer<IncentiveProvider>(
          builder: (context, model, _) {
            if (model.selectedPackage == null) {
              return Center(child: CircularProgressIndicator());
            }

            var packageIncentives = model.selectedPackageIncentives();
            return ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                List<Widget> widgets = [
                  Flexible(
                    child: Text(
                      packageIncentives[index].name,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ];

                return MyListing(
                  widgets,
                  myOnTap: () => _selectIncentive(packageIncentives[index]),
                  shouldGradient: false,
                );
              },
              itemCount: packageIncentives.length,
            );
            // return Column(
            //   children: packageIncentives.map((incentive) {
            //     return Card(
            //       child: ListTile(
            //         contentPadding:
            //             EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            //         title: Text(
            //           incentive.name,
            //           style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         trailing: Icon(Icons.navigate_next),
            //         onTap: () {
            //           _selectIncentive(incentive);
            //         },
            //       ),
            //     );
            //   }).toList(),
            // );
          },
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
