import 'package:eicapp/providers/chinese_page.dart';
import 'package:eicapp/providers/setting.dart';
import 'package:eicapp/screens/chinese_page.dart';
import 'package:eicapp/screens/country_profile_list.dart';
import 'package:eicapp/screens/feedback.dart';
import 'package:eicapp/screens/incentive_package_list.dart';
import 'package:eicapp/screens/news_list.dart';
import 'package:eicapp/screens/opportunity_list.dart';
import 'package:eicapp/screens/sector_list.dart';
import 'package:eicapp/screens/service_list.dart';
import 'package:eicapp/screens/setting_list.dart';
import 'package:eicapp/screens/step_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> menu;
    if (Provider.of<SettingProvider>(context, listen: false).language ==
        Language.Chinese) {
      menu = <Widget>[
        buildDrawerHeader(context),
        Consumer<ChinesePageProvider>(builder: (context, model, _) {
          return Column(
            children: [
              ...List.generate(model.allChinesePages.length, (index) {
                void callback() {
                  Provider.of<ChinesePageProvider>(context, listen: false)
                      .selectChinesePage(model.allChinesePages[index]);
                }

                return _buildDrawerItem(
                  context: context,
                  itemName: model.allChinesePages[index].name,
                  screenId: ChinesePageScreen.id,
                  callback: callback,
                  iconData: FontAwesomeIcons.caretRight,
                );
              }),
              _buildDrawerItem(
                context: context,
                itemName: '联系',
                screenId: FeedbackScreen.id,
                iconData: FontAwesomeIcons.phone,
              ),
              _buildDrawerItem(
                context: context,
                itemName: '设置',
                screenId: SettingListScreen.id,
                iconData: FontAwesomeIcons.cog,
              )
            ],
          );
        })
      ];
    } else {
      menu = <Widget>[
        buildDrawerHeader(context),
        _buildDrawerItem(
            context: context,
            itemName: 'News and Events',
            screenId: NewsListScreen.id,
            iconData: FontAwesomeIcons.newspaper),
        _buildDrawerItem(
            context: context,
            itemName: 'Country Profile',
            screenId: CountryProfileListScreen.id,
            iconData: FontAwesomeIcons.globeAfrica),
        _buildDrawerItem(
            context: context,
            itemName: 'Services',
            screenId: ServiceListScreen.id,
            iconData: FontAwesomeIcons.cogs),
        _buildDrawerItem(
            context: context,
            itemName: 'Investment Incentives',
            screenId: IncentivePackageListScreen.id,
            iconData: FontAwesomeIcons.drumstickBite),
        _buildDrawerItem(
            context: context,
            itemName: 'Sectors',
            screenId: SectorListScreen.id,
            iconData: FontAwesomeIcons.industry),
        _buildDrawerItem(
            context: context,
            itemName: 'Investment Opportunities',
            screenId: OpportunityListScreen.id,
            iconData: FontAwesomeIcons.solidLightbulb),
        _buildDrawerItem(
            context: context,
            itemName: 'Steps',
            screenId: StepListScreen.id,
            iconData: FontAwesomeIcons.paw),
        _buildDrawerItem(
            context: context,
            itemName: 'Contact',
            screenId: FeedbackScreen.id,
            iconData: FontAwesomeIcons.phone),
        _buildDrawerItem(
            context: context,
            itemName: 'Setting',
            screenId: SettingListScreen.id,
            iconData: FontAwesomeIcons.cog),
      ];
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: menu,
      ),
    );
  }

  DrawerHeader buildDrawerHeader(BuildContext context) {
    return DrawerHeader(
      padding: EdgeInsets.zero,
      // margin: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          // color: Theme.of(context).primaryColor,

          image: DecorationImage(
            image: AssetImage('assets/images/background3.jpg'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomCenter,
            colorFilter: ColorFilter.mode(
              Colors.grey,
              BlendMode.exclusion,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Image.asset(
              'assets/images/logo-small.png',
              fit: BoxFit.contain,
            ),
            // SizedBox(
            //   height: 10.0,
            // ),
            _buildEicName("Ethiopian", context),
            _buildEicName("Investment", context),
            _buildEicName("Commission", context),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
    );
  }

  Text _buildEicName(String title, BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: Theme.of(context).textTheme.title.fontFamily,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
        shadows: [
          Shadow(
            color: Colors.black87,
            blurRadius: 10.0,
            offset: Offset.fromDirection(1),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      {Function callback,
      BuildContext context,
      String itemName,
      String screenId,
      IconData iconData}) {
    final Icon icon = iconData != null
        ? Icon(
            iconData,
            size: 20.0,
          )
        : null;

    return InkWell(
      splashColor: Theme.of(context).primaryColor,

      // leading: Icon(Icons.arrow_right),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            style: BorderStyle.solid,
            color: Colors.grey[200],
          ),
        )),
        child: ListTile(
          // leading: icon,
          title: Text(
            itemName,
            textAlign: TextAlign.left,
          ),
          trailing: Icon(
            FontAwesomeIcons.angleRight,
            size: 14.0,
          ),
        ),
      ),
      onTap: () {
        if (callback != null) callback();
        Navigator.pop(context);
        Navigator.pushNamed(context, screenId);
      },
    );
  }
}
