import 'package:eicapp/providers/sector.dart';
import 'package:eicapp/util/ui_builder.dart';
import 'package:eicapp/widgets/loading.dart';
import 'package:eicapp/widgets/myappbar.dart';
import 'package:eicapp/widgets/page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    if (args != null) {
      Provider.of<SectorProvider>(context).selectSectorByAttributes(args);
    }

    if (Provider.of<SectorProvider>(context).selectedSector == null) {
      return Loading(
        isPage: true,
      );
    }

    String title = Provider.of<SectorProvider>(context).selectedSector.name;
    return Page(
      appBar: MyAppBar(
        context,
        title: title,
      ),
      background: false,
      pageContent: WillPopScope(
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
