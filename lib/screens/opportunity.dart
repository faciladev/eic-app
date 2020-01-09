// import 'package:eicapp/providers/opportunity.dart';
import 'package:eicapp/providers/country_profile.dart';
import 'package:eicapp/util/ui_builder.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Consumer<CountryProfileProvider>(
          builder: (context, model, _) {
            return Text(
              model.selectedOpportunity?.name,
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
