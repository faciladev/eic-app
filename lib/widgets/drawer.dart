import 'package:eicapp/providers/chinese_page.dart';
import 'package:eicapp/providers/setting.dart';
import 'package:eicapp/screens/chinese_page.dart';
import 'package:eicapp/screens/country_profile_list.dart';
import 'package:eicapp/screens/feedback.dart';
import 'package:eicapp/screens/incentive_package_list.dart';
import 'package:eicapp/screens/news_list.dart';
import 'package:eicapp/screens/sector_list.dart';
import 'package:eicapp/screens/service_list.dart';
import 'package:eicapp/screens/setting_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:eicapp/providers/language.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> menu;
    if (Provider.of<SettingProvider>(context, listen: false).language ==
        Language.Chinese) {
      menu = <Widget>[
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
        Consumer<ChinesePageProvider>(builder: (context, model, _) {
          return Column(
            children: [
              ...List.generate(model.allChinesePages.length, (index) {
                return ListTile(
                  // leading: Icon(Icons.arrow_right),
                  title: Text(model.allChinesePages[index].name),
                  onTap: () {
                    Provider.of<ChinesePageProvider>(context, listen: false)
                        .selectChinesePage(model.allChinesePages[index]);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, ChinesePageScreen.id);
                  },
                );
              }),
              _buildDrawerItem(context, '联系', FeedbackScreen.id),
              _buildDrawerItem(context, '设置', SettingListScreen.id)
            ],
          );
        })
      ];
    } else {
      menu = <Widget>[
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
        _buildDrawerItem(context, 'News and Events', NewsListScreen.id),
        _buildDrawerItem(
            context, 'Country Profile', CountryProfileListScreen.id),
        _buildDrawerItem(context, 'Services', ServiceListScreen.id),
        _buildDrawerItem(
            context, 'Investment Incentives', IncentivePackageListScreen.id),
        _buildDrawerItem(context, 'Sectors', SectorListScreen.id),
        _buildDrawerItem(
            context, 'Investment Opportunities', FeedbackScreen.id),
        _buildDrawerItem(context, 'Steps', FeedbackScreen.id),
        _buildDrawerItem(context, 'Contact', FeedbackScreen.id),
        _buildDrawerItem(context, 'Setting', SettingListScreen.id),
      ];
    }

    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: menu,
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
