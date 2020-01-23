import 'package:eicapp/models/chinese_page.dart';
import 'package:eicapp/providers/chinese_page.dart';
import 'package:eicapp/providers/setting.dart';
import 'package:eicapp/screens/chinese_page.dart';
import 'package:eicapp/screens/feedback.dart';
import 'package:eicapp/screens/incentive_package_list.dart';
import 'package:eicapp/screens/opportunity_list.dart';
import 'package:eicapp/screens/sector_list.dart';
import 'package:eicapp/screens/service_list.dart';
import 'package:eicapp/screens/step_list.dart';
import 'package:eicapp/util/ui_builder.dart';
import 'package:eicapp/widgets/drawer.dart';
import 'package:eicapp/widgets/myappbar.dart';
import 'package:eicapp/widgets/page.dart';
import 'package:eicapp/widgets/stackPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
          pageContent: _buildDashboardMenu(context, language: model.language),
          // pageContentOffsetPercent: 0.40,
        );
      },
    );
  }

  Widget _buildDashboardMenu(BuildContext context, {Language language}) {
    if (language == Language.English) {
      List<Widget> children = [
        _buildMenuItem(context,
            title: 'Profile',
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
            screenId: OpportunityListScreen.id),
        _buildMenuItem(context,
            title: 'Steps',
            iconData: FontAwesomeIcons.paw,
            color: Colors.tealAccent,
            screenId: StepListScreen.id),
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
                // _buildMenuItem(
                //   context,
                //   title: '联系',
                //   iconData: FontAwesomeIcons.phone,
                //   color: Colors.amber,
                //   screenId: FeedbackScreen.id,
                // ),
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

  Widget _buildDashboard(BuildContext context, {List<Widget> children}) {
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(10),
      crossAxisCount: 3,
      itemCount: children.length,
      itemBuilder: (BuildContext context, int index) => new Container(
        child: children[index],
      ),
      staggeredTileBuilder: (int index) => new StaggeredTile.count(
          _getCrossAxisSpan(index), _getMainAxisSpan(index)),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  int _getCrossAxisSpan(int index) {
    if (index == 0 || index % 3 == 0) return 3;
    if (index % 4 == 0 || index % 2 == 0) return 2;
    return 1;
  }

  int _getMainAxisSpan(int index) {
    // if (index == 0 || index % 3 == 0) return 2;
    // if (index % 4 == 0 || index % 2 == 0) return 2;
    return 1;
  }

  List<Widget> _buildIndentedRow(List<Widget> children) {
    List<Widget> rows = [];
    final int crossAxisCount = 3;
    // children.insert(0, _buildInvisibleMenu());
    // while (children.length % 3 != 0) {
    //   children.add(_buildInvisibleMenu());
    // }

    for (int cellIndex = 0;
        cellIndex < children.length;
        cellIndex = cellIndex + crossAxisCount) {
      List<Widget> rowTemp = [];

      int rightBound =
          _calculateRightBound(cellIndex, crossAxisCount, children);

      for (int cellCount = cellIndex; cellCount < rightBound; cellCount++) {
        rowTemp.add(children[cellCount]);
        if (cellCount + 1 == rightBound) {
          rows.add(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: rowTemp,
          ));

          // rows.add(SizedBox(
          //   height: 15.0,
          // ));
        }
      }
    }
    return rows;
  }

  Container _buildInvisibleMenu() {
    return Container(
      width: 125,
      height: 125,
    );
  }

  int _calculateRightBound(
      int cellIndex, int crossAxisCount, List<Widget> children) {
    int rightBound;
    if (cellIndex + crossAxisCount >= children.length) {
      rightBound = children.length;
    } else {
      rightBound = cellIndex + crossAxisCount;
    }
    return rightBound;
  }

  Widget _buildMenuItem(BuildContext context,
      {String title,
      IconData iconData,
      Color color,
      String screenId,
      ChinesePage page}) {
    return Container(
      margin: EdgeInsets.all(5.0),
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
            Navigator.pushNamed(context, screenId);
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
                    title.toUpperCase(),
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontFamily: Theme.of(context).textTheme.body1.fontFamily,
                      fontSize: 17.0,
                      color: Colors.white,

                      // color: Colors.white,
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
