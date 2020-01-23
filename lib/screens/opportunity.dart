// import 'package:eicapp/providers/opportunity.dart';
import 'package:eicapp/providers/country_profile.dart';
import 'package:eicapp/util/ui_builder.dart';
import 'package:eicapp/widgets/myappbar.dart';
import 'package:eicapp/widgets/page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class OpportunityScreen extends StatefulWidget {
  static final String id = 'opportunity_screen';
  @override
  State<StatefulWidget> createState() {
    return _OpportunityScreenState();
  }
}

class _OpportunityScreenState extends State<OpportunityScreen> {
  @override
  Widget build(BuildContext context) {
    String title =
        Provider.of<CountryProfileProvider>(context).selectedOpportunity.name;
    return Page(
      appBar: MyAppBar(
        context,
        title: title,
      ),
      background: false,
      pageContent: WillPopScope(
        child: SingleChildScrollView(
          child: Consumer<CountryProfileProvider>(
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
                            model.selectedOpportunity.content, context)
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        onWillPop: () {
          Provider.of<CountryProfileProvider>(context, listen: false)
              .unselectOpportunity();
          return Future.value(true);
        },
      ),
    );
  }
}
