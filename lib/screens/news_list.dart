import 'package:cached_network_image/cached_network_image.dart';
import 'package:eicapp/providers/news.dart';
import 'package:eicapp/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'news.dart';

class NewsListScreen extends StatefulWidget {
  static final String id = 'news_list_screen';
  @override
  State<StatefulWidget> createState() {
    return _NewsListScreenState();
  }
}

class _NewsListScreenState extends State<NewsListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NewsProvider>(context, listen: false).fetchAllNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          context,
          title: 'News and Events',
        ),
        body: RefreshIndicator(
          child: _buildAllNews(),
          onRefresh: () {
            return Provider.of<NewsProvider>(context, listen: false)
                .fetchAllNews();
          },
        ));
  }

  Widget _buildAllNews() {
    return Consumer<NewsProvider>(
      builder: (context, news, child) {
        if (news.allNews == null) {
          return Center(child: CircularProgressIndicator());
        }
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!news.isLoading &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              news.fetchAllNews();
            }
            return true;
          },
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              Widget image = CachedNetworkImage(
                imageUrl: news.allNews[index].image,
                width: 90.0,
                fit: BoxFit.none,
              );

              return Card(
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  subtitle: Text(news.allNews[index].published),
                  leading: image,
                  title: Text(
                    news.allNews[index].title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(Icons.navigate_next),
                  onTap: () => _selectNews(index),
                ),
              );
            },
            itemCount: news.allNews.length,
          ),
        );
      },
    );
  }

  void _selectNews(int index) {
    Provider.of<NewsProvider>(context, listen: false).selectNews(index);
    Navigator.pushNamed(context, NewsScreen.id);
  }
}
