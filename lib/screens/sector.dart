import 'package:eicapp/providers/sector.dart';
import 'package:eicapp/util/ui_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class SectorScreen extends StatefulWidget {
  static final String id = 'sector_screen';
  @override
  State<StatefulWidget> createState() {
    return _SectorScreenState();
  }
}

class _SectorScreenState extends State<SectorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<SectorProvider>(
          builder: (context, model, _) {
            return Text(
              model.selectedSector?.name,
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
          child: Consumer<SectorProvider>(
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
                        buildNestedContent(
                            model.selectedSector.content, context)
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        onWillPop: () {
          Provider.of<SectorProvider>(context, listen: false).unselectSector();
          return Future.value(true);
        },
      ),
    );
  }
}
