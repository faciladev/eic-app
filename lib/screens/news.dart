import 'package:cached_network_image/cached_network_image.dart';
import 'package:eicapp/providers/news.dart';
import 'package:eicapp/util/ui_builder.dart';
import 'package:eicapp/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  static final String id = 'news_screen';
  @override
  State<StatefulWidget> createState() {
    return _NewsScreenState();
  }
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    if (args != null) {
      Provider.of<NewsProvider>(context).selectNewsByAttributes(args);
    }

    if (Provider.of<NewsProvider>(context).selectedNews == null) {
      return Loading(
        isPage: true,
      );
    }
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          Provider.of<NewsProvider>(context, listen: false).unselectNews();
          return Future.value(true);
        },
        child: Consumer<NewsProvider>(builder: (context, model, _) {
          Orientation orientation = MediaQuery.of(context).orientation;
          Size size = MediaQuery.of(context).size;
          double heightPercent =
              orientation == Orientation.landscape ? 0.6 : 0.4;
          double appBarHeight = size.height * heightPercent;
          return SafeArea(
            top: true,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  floating: true,
                  expandedHeight: appBarHeight,
                  flexibleSpace: Container(
                    child: CachedNetworkImage(
                      imageUrl: model.selectedNews.image,
                      fit: BoxFit.cover,
                      height: appBarHeight,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 17,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    model.selectedNews.title,
                                    style: Theme.of(context).textTheme.headline,
                                  ),
                                ),
                                SizedBox(
                                  height: 17,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    model.selectedNews.published,
                                    style: Theme.of(context).textTheme.subtitle,
                                  ),
                                ),
                                SizedBox(
                                  height: 17,
                                ),
                                buildNestedContent(
                                    model.selectedNews.content, context)
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    childCount: 1,
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
