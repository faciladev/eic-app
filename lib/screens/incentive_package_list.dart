import 'package:eicapp/providers/incentive.dart';
import 'package:eicapp/screens/incentive_list.dart';
import 'package:eicapp/widgets/drawer.dart';
import 'package:eicapp/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncentivePackageListScreen extends StatefulWidget {
  static final String id = 'incentive_package_list_screen';
  @override
  _IncentivePackageListScreenState createState() =>
      _IncentivePackageListScreenState();
}

class _IncentivePackageListScreenState
    extends State<IncentivePackageListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<IncentiveProvider>(context, listen: false).fetchAllIncentives();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context,
        title: 'Investment Incentives',
      ),
      // endDrawer: MyDrawer(),
      body: RefreshIndicator(
        child: _buildPackages(),
        onRefresh: () {
          return Provider.of<IncentiveProvider>(context, listen: false)
              .fetchAllIncentives();
        },
      ),
    );
  }

  Widget _buildPackages() {
    return Consumer<IncentiveProvider>(
      builder: (context, incentive, child) {
        if (incentive.packages.length == 0) {
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
                  incentive.packages[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(Icons.navigate_next),
                onTap: () => _selectPackage(incentive.packages[index]),
              ),
            );
          },
          itemCount: incentive.packages.length,
        );
      },
    );
  }

  void _selectPackage(String packageName) {
    Provider.of<IncentiveProvider>(context, listen: false)
        .selectPackage(packageName);
    Navigator.pushNamed(context, IncentiveListScreen.id);
  }
}
