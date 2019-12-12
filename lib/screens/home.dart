import 'package:eicapp/models/chinese_page.dart';
import 'package:eicapp/providers/chinese_page.dart';
import 'package:eicapp/providers/setting.dart';
import 'package:eicapp/screens/chinese_page.dart';
import 'package:eicapp/screens/feedback.dart';
import 'package:eicapp/screens/incentive_package_list.dart';
import 'package:eicapp/screens/sector_list.dart';
import 'package:eicapp/screens/service_list.dart';
import 'package:eicapp/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'country_profile_list.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    if (Provider.of<SettingProvider>(context, listen: false).language ==
        Language.Chinese) {
      Provider.of<ChinesePageProvider>(context, listen: false)
          .fetchAllChinesePages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, model, child) {
        String pageTitle;
        if (model.language == Language.English) {
          pageTitle = 'EIC';
        } else if (model.language == Language.Chinese) {
          pageTitle = 'EIC 中文';
        }

        // return NewsListScreen();
        return Scaffold(
          backgroundColor: Colors.blueGrey[50],
          appBar: AppBar(
            title: Text(
              pageTitle ?? '...',
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.title.fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          drawer: MyDrawer(),
          body: _buildDashboardMenu(context, language: model.language),
        );
      },
    );
  }

  Widget _buildDashboardMenu(BuildContext context, {Language language}) {
    if (language == Language.English) {
      List<Widget> children = [
        _buildMenuItem(context,
            title: 'Country Profile',
            iconData: FontAwesomeIcons.globeAfrica,
            color: Colors.cyan,
            screenId: CountryProfileListScreen.id),
        _buildMenuItem(context,
            title: 'Services',
            iconData: FontAwesomeIcons.cogs,
            color: Colors.deepOrange[200],
            screenId: ServiceListScreen.id),
        _buildMenuItem(context,
            title: 'Incentives',
            iconData: FontAwesomeIcons.drumstickBite,
            color: Colors.deepPurple[200],
            screenId: IncentivePackageListScreen.id),
        _buildMenuItem(context,
            title: 'Sectors',
            iconData: FontAwesomeIcons.industry,
            color: Colors.greenAccent,
            screenId: SectorListScreen.id),
        _buildMenuItem(context,
            title: 'Opportunities',
            iconData: FontAwesomeIcons.solidLightbulb,
            color: Colors.redAccent,
            screenId: CountryProfileListScreen.id),
        _buildMenuItem(context,
            title: 'Steps',
            iconData: FontAwesomeIcons.paw,
            color: Colors.tealAccent,
            screenId: CountryProfileListScreen.id),
        _buildMenuItem(context,
            title: 'Contact',
            iconData: FontAwesomeIcons.phone,
            color: Colors.amber,
            screenId: FeedbackScreen.id),
      ];
      return _buildDashboard(context, children: children);
    } else {
      return RefreshIndicator(
        child: Consumer<ChinesePageProvider>(
          builder: (context, model, _) {
            if (model.allChinesePages == null) {
              return Center(child: CircularProgressIndicator());
            }
            return _buildDashboard(
              context,
              children: <Widget>[
                ...model.allChinesePages.map((page) {
                  return _buildMenuItem(
                    context,
                    title: page.name,
                    screenId: ChinesePageScreen.id,
                    page: page,
                  );
                }).toList(),
                _buildMenuItem(context,
                    title: '联系',
                    iconData: FontAwesomeIcons.phone,
                    color: Colors.amber,
                    screenId: FeedbackScreen.id),
              ],
            );
          },
        ),
        onRefresh: () {
          return Provider.of<ChinesePageProvider>(context, listen: false)
              .fetchAllChinesePages();
        },
      );
    }
  }

  GridView _buildDashboard(BuildContext context, {List<Widget> children}) {
    return GridView.count(
        padding: EdgeInsets.all(30.0), crossAxisCount: 2, children: children);
  }

  Card _buildMenuItem(BuildContext context,
      {String title,
      IconData iconData,
      Color color,
      String screenId,
      ChinesePage page}) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        splashColor: Theme.of(context).primaryColor,
        onTap: () {
          if (page != null) {
            Provider.of<ChinesePageProvider>(context, listen: false)
                .selectChinesePage(page);
          }
          Navigator.pushNamed(context, screenId);
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              iconData == null
                  ? Container()
                  : Icon(
                      iconData,
                      size: 50.0,
                      color: color,
                    ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: Theme.of(context).textTheme.title.fontFamily,
                    fontSize: 17.0,
                    color: Colors.black54),
              )
            ],
          ),
        ),
      ),
    );
  }
}
