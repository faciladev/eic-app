import 'package:eicapp/providers/country_profile.dart';
import 'package:eicapp/util/ui_builder.dart';
import 'package:eicapp/widgets/loading.dart';
import 'package:eicapp/widgets/myappbar.dart';
import 'package:eicapp/widgets/page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryProfileScreen extends StatefulWidget {
  static final String id = 'country_profile_screen';

  @override
  State<StatefulWidget> createState() {
    return _CountryProfileScreenState();
  }
}

class _CountryProfileScreenState extends State<CountryProfileScreen> {
  @override
  Widget build(BuildContext context) {
    String title;
    Widget pageContent;

    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    if (args != null) {
      Provider.of<CountryProfileProvider>(context)
          .selectCountryProfileByName(args['name']);
    }

    if (Provider.of<CountryProfileProvider>(context).selectedCountryProfile ==
        null) {
      return Loading(
        isPage: true,
      );
    }

    title = Provider.of<CountryProfileProvider>(context)
        .selectedCountryProfile
        .name;

    pageContent = WillPopScope(
      child: SingleChildScrollView(
        child: Consumer<CountryProfileProvider>(
          builder: (context, model, _) {
            if (model.selectedCountryProfile == null) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(child: CircularProgressIndicator()),
              );
            }

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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          model.selectedCountryProfile.name,
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      buildNestedContent(
                          model.selectedCountryProfile.content, context)
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
            .unselectCountryProfile();
        return Future.value(true);
      },
    );

    return Page(
      appBar: MyAppBar(
        context,
        title: title,
      ),
      background: false,
      pageContent: pageContent,
    );
  }
}
