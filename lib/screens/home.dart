import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eicapp/models/chinese_page.dart';
import 'package:eicapp/providers/chinese_page.dart';
import 'package:eicapp/providers/setting.dart';
import 'package:eicapp/screens/chinese_page.dart';
import 'package:eicapp/screens/country_profile.dart';
import 'package:eicapp/screens/incentive_package_list.dart';
import 'package:eicapp/screens/sector_list.dart';
import 'package:eicapp/screens/service_list.dart';
import 'package:eicapp/widgets/drawer.dart';
import 'package:eicapp/widgets/myappbar.dart';
import 'package:eicapp/widgets/page.dart';
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
          pageTitle = 'Invest in Ethiopia';
        } else if (model.language == Language.Chinese) {
          pageTitle = '投资埃塞俄比亚';
        }

        return Page(
            appBar: MyAppBar(
              context,
              title: pageTitle ?? '...',
            ),
            drawer: MyDrawer(),
            // customClipper: MyPathClipper(height1: 0.43, height2: 0.55),
            // shadow: Shadow(blurRadius: 10),
            // image: DecorationImage(
            //   image: AssetImage('assets/images/home1.jpg'),
            //   fit: BoxFit.cover,
            //   alignment: Alignment.topCenter,
            // ),
            pageContent: Container(
                height: MediaQuery.of(context).size.height,
                child: CustomScrollView(slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: CarouselSlider(
                            autoPlay: true,
                            autoPlayAnimationDuration: Duration(seconds: 5),
                            pauseAutoPlayOnTouch: Duration(seconds: 10),
                            // enlargeCenterPage: true,
                            height: MediaQuery.of(context).size.height * 0.30,
                            items: [2, 3, 4].map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: Colors.black87,
                                        )
                                      ],
                                      color: Theme.of(context).primaryColor,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/background$i.jpg'),
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          'Tourism Sector is booming',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            backgroundColor:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                  SliverGrid(
                    delegate: SliverChildListDelegate(
                      _buildDashboardMenu(context, language: model.language),
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                  ),
                ]
                    // _buildDashboardMenu(context, language: model.language)),
                    ))

            // pageContentOffsetPercent: 0.40,
            );
      },
    );
  }

  List<Widget> _buildDashboardMenu(BuildContext context, {Language language}) {
    if (language == Language.English) {
      List<Widget> children = [
        _buildMenuItem(
          context,
          title: 'Get Started',
          iconData: FontAwesomeIcons.paw,
          color: Colors.tealAccent,
        ),
        _buildMenuItem(
          context,
          title: 'Profile',
          iconData: FontAwesomeIcons.globeAfrica,
          color: Colors.cyan,
          screenId: CountryProfileListScreen.id,
        ),
        _buildMenuItem(
          context,
          title: 'Opportunities',
          iconData: FontAwesomeIcons.solidLightbulb,
          color: Colors.redAccent,
        ),
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
            screenId: SectorListScreen.id)
        // _buildMenuItem(context,
        //     title: 'Contact',
        //     iconData: FontAwesomeIcons.phone,
        //     color: Colors.amber,
        //     screenId: FeedbackScreen.id),
        // _buildMenuItem(context,
        //     title: 'Setting',
        //     iconData: FontAwesomeIcons.cog,
        //     color: Colors.amber,
        //     screenId: FeedbackScreen.id),
      ];
      return _buildDashboard(context, children: children);
    } else {
      //Chinese Page
      if (Provider.of<ChinesePageProvider>(context).allChinesePages == null) {
        return [Center(child: CircularProgressIndicator())];
      } else {
        return _buildDashboard(
          context,
          children: <Widget>[
            ...Provider.of<ChinesePageProvider>(context)
                .allChinesePages
                .map((page) {
              return _buildMenuItem(
                context,
                title: page.name,
                screenId: ChinesePageScreen.id,
                page: page,
              );
            }).toList(),
            // _buildMenuItem(
            //   context,
            //   title: '联系',
            //   iconData: FontAwesomeIcons.phone,
            //   color: Colors.amber,
            //   screenId: FeedbackScreen.id,
            // ),
          ],
        );
      }
    }
  }

  List<Widget> _buildDashboard(BuildContext context, {List<Widget> children}) {
    return children;
  }

  Widget _buildMenuItem(BuildContext context,
      {String title,
      IconData iconData,
      Color color,
      String screenId,
      ChinesePage page}) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 3)],
        borderRadius: BorderRadius.circular(10),
      ),
      //Needed to keep the InkWell ripple effect
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor.withOpacity(0.9),
        child: InkWell(
          splashColor: Theme.of(context).accentColor,
          onTap: () {
            if (page != null) {
              Provider.of<ChinesePageProvider>(context, listen: false)
                  .selectChinesePage(page);
            }
            if (title == "Get Started") {
              Navigator.pushNamed(context, CountryProfileScreen.id,
                  arguments: <String, String>{
                    "profileName": title,
                  });
            } else if (title == "Opportunities") {
              Navigator.pushNamed(context, CountryProfileScreen.id,
                  arguments: <String, String>{
                    "profileName": "Growth Sectors and Opportunities",
                  });
            } else {
              Navigator.pushNamed(context, screenId);
            }
          },
          child: Container(
            height: 120,
            width: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                iconData == null
                    ? Container()
                    : Icon(
                        iconData,
                        size: 50.0,
                        color: color,
                        // color: Colors.white,
                      ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
