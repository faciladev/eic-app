import 'package:eicapp/providers/country_profile.dart';
import 'package:eicapp/util/ui_builder.dart';
import 'package:eicapp/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StepScreen extends StatefulWidget {
  static final String id = 'step_screen';
  @override
  State<StatefulWidget> createState() {
    return _StepScreenState();
  }
}

class _StepScreenState extends State<StepScreen> {
  @override
  Widget build(BuildContext context) {
    String title =
        Provider.of<CountryProfileProvider>(context).selectedStep.name;
    return Scaffold(
      appBar: MyAppBar(
        context,
        title: title,
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
                        buildNestedContent(model.selectedStep.content, context)
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
              .unselectStep();
          return Future.value(true);
        },
      ),
    );
  }
}
