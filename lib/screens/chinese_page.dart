import 'package:eicapp/providers/chinese_page.dart';
import 'package:eicapp/util/ui_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ChinesePageScreen extends StatefulWidget {
  static final String id = 'chinese_page_screen';
  @override
  State<StatefulWidget> createState() {
    return _ChinesePageScreenState();
  }
}

class _ChinesePageScreenState extends State<ChinesePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ChinesePageProvider>(
          builder: (context, model, _) {
            return Text(
              model.selectedChinesePage?.name,
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.title.fontFamily,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {},
          )
        ],
      ),
      body: WillPopScope(
        child: SingleChildScrollView(
          child: Consumer<ChinesePageProvider>(
            builder: (context, model, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 17,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: FadeInImage.memoryNetwork(
                            fit: BoxFit.cover,
                            placeholder: kTransparentImage,
                            image: model.selectedChinesePage.image,
                          ),
                        ),
                        buildNestedContent(
                            model.selectedChinesePage.content, context)
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        onWillPop: () {
          Provider.of<ChinesePageProvider>(context, listen: false)
              .unselectChinesePage();
          return Future.value(true);
        },
      ),
    );
  }
}
