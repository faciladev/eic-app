import 'package:eicapp/providers/sector.dart';
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
                        _buildNestedContent(model.selectedSector.content)
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

  Widget _buildNestedContent(dynamic root) {
    if (root == null) return Container();

    List nodeStack = [];
    List<Widget> body = [];
    try {
      Map<String, dynamic> mapData = root;
      mapData.forEach((String key, dynamic value) {
        nodeStack.add('__title__$key');
        nodeStack.add(value);
        nodeStack.add('__divider__');
      });
    } catch (e) {
      List<dynamic> listData = root;
      listData.forEach((item) {
        nodeStack.add(item);
      });
    }

    while (nodeStack.length > 0) {
      var node = nodeStack.removeLast();
      try {
        Map<String, dynamic> mapData = node;
        mapData.forEach((String key, dynamic value) {
          nodeStack.add('__title__$key');
          nodeStack.add(value);
          nodeStack.add('__divider__');
        });
      } catch (e) {
        try {
          List<dynamic> listData = node;
          listData.forEach((item) {
            nodeStack.add(item);
          });
        } catch (e) {
          String stringData = node;

          if (stringData.startsWith('__title__')) {
            stringData = stringData.replaceFirst('__title__', '');
            if (stringData == 'text' || stringData == 'images') {
              continue;
            }
            body.insert(
                0,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    stringData,
                    style: Theme.of(context).textTheme.title,
                  ),
                ));
          } else if (stringData.startsWith('__divider__')) {
            body.insert(
                0,
                SizedBox(
                  height: 17.0,
                ));
          } else {
            body.insert(
              0,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  stringData,
                  style: TextStyle(
                    fontFamily: Theme.of(context).textTheme.title.fontFamily,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }
        }
      }
    }

    return body.length > 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: body,
          )
        : Container();
  }
}
