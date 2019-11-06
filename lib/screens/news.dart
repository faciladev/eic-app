import 'package:eicapp/models/news.dart';
import 'package:eicapp/providers/news.dart';
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
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {},
          )
        ],
      ),
      body: WillPopScope(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: SafeArea(
                top: false,
                child: Consumer<NewsProvider>(
                  builder: (context, model, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: FadeInImage.memoryNetwork(
                            fit: BoxFit.fitWidth,
                            placeholder: kTransparentImage,
                            image: model.selectedNews.image,
                          ),
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                model.selectedNews.title,
                                style: Theme.of(context).textTheme.title,
                              ),
                              SizedBox(
                                height: 17,
                              ),
                              Text(
                                model.selectedNews.content.join('\n\n'),
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
                ),
              ),
            ),
          ],
        ),
        onWillPop: () {
          Provider.of<NewsProvider>(context, listen: false).unselectNews();
          return Future.value(true);
        },
      ),
    );
  }
}
