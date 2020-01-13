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
          pageTitle = 'Invest in Ethiopia';
        } else if (model.language == Language.Chinese) {
          pageTitle = '投资埃塞俄比亚';
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
          body: Stack(
            children: [
              Container(
                color: Colors.grey,
                // decoration: BoxDecoration(
                //     // image: DecorationImage(
                //     //   image: AssetImage('assets/images/background2.jpg'),
                //     //   fit: BoxFit.cover,
                //     // ),
                //     ),
              ),
              ClipPath(
                clipBehavior: Clip.hardEdge,
                clipper: MyPathClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              _buildDashboardMenu(context, language: model.language)
            ],
          ),
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
    List<Widget> rows = _buildIndentedRow(children);
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.40),
      child: ListView.builder(
        itemCount: rows.length,
        // scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return rows[index];
        },
      ),
    );
  }

  List<Widget> _buildIndentedRow(List<Widget> children) {
    List<Widget> rows = [];
    final int crossAxisCount = 3;
    // children.insert(0, _buildInvisibleMenu());
    while (children.length % 3 != 0) {
      children.add(_buildInvisibleMenu());
    }

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    return Card(
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.all(5.0),
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        onTap: () {
          if (page != null) {
            Provider.of<ChinesePageProvider>(context, listen: false)
                .selectChinesePage(page);
          }
          Navigator.pushNamed(context, screenId);
        },
        child: SizedBox(
          height: 120,
          width: 120,
          // padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
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
                    fontWeight: FontWeight.bold,
                    fontFamily: Theme.of(context).textTheme.title.fontFamily,
                    fontSize: 15.0,
                    color: Colors.white70,
                    // color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height * 0.40);
    path.lineTo(0.0, size.height * 0.55);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
