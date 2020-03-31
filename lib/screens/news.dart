import 'package:eicapp/providers/news.dart';
import 'package:eicapp/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

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
          return SafeArea(
            top: true,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  floating: true,
                  expandedHeight: 200,
                  flexibleSpace: Container(
                    child: FadeInImage.memoryNetwork(
                      fit: BoxFit.cover,
                      placeholder: kTransparentImage,
                      image: model.selectedNews.image,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Container(
                          //   child: FadeInImage.memoryNetwork(
                          //     fit: BoxFit.fitWidth,
                          //     placeholder: kTransparentImage,
                          //     image: model.selectedNews.image,
                          //   ),
                          // ),
                          SizedBox(
                            height: 17,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  model.selectedNews.title,
                                  style: Theme.of(context).textTheme.headline,
                                ),
                                SizedBox(
                                  height: 17,
                                ),
                                Text(
                                  model.selectedNews.published,
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                                SizedBox(
                                  height: 17,
                                ),
                                Text(
                                  model.selectedNews.content,
                                  style: TextStyle(
                                    fontFamily: Theme.of(context)
                                        .textTheme
                                        .title
                                        .fontFamily,
                                    fontSize: 16,
                                  ),
                                ),
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
