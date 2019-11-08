import 'package:eicapp/screens/country_profile_list.dart';
import 'package:eicapp/screens/feedback.dart';
import 'package:eicapp/screens/incentive_package_list.dart';
import 'package:eicapp/screens/sector_list.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.zero,
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/logo-small.png',
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 17),
                Text(
                  'Ethiopian Investment Commission',
                  style: TextStyle(
                    fontFamily: Theme.of(context).textTheme.title.fontFamily,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          _buildDrawerItem(
              context, 'Country Profile', CountryProfileListScreen.id),
          _buildDrawerItem(context, 'Services', FeedbackScreen.id),
          _buildDrawerItem(
              context, 'Investment Incentives', IncentivePackageListScreen.id),
          _buildDrawerItem(context, 'Sectors', SectorListScreen.id),
          _buildDrawerItem(
              context, 'Investment Opportunities', FeedbackScreen.id),
          _buildDrawerItem(context, 'Steps', FeedbackScreen.id),
          _buildDrawerItem(context, 'Contact', FeedbackScreen.id),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(
      BuildContext context, String itemName, String screenId) {
    return ListTile(
      // leading: Icon(Icons.arrow_right),
      title: Text(itemName),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, screenId);
      },
    );
  }
}
