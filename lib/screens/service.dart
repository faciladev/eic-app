import 'package:eicapp/providers/service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ServiceScreen extends StatefulWidget {
  static final String id = 'service_screen';
  @override
  State<StatefulWidget> createState() {
    return _ServiceScreenState();
  }
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ServiceProvider>(
          builder: (context, model, _) {
            return Text(
              model.selectedService.name,
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
          child: Consumer<ServiceProvider>(
            builder: (context, model, _) {
              return _buildRequirements(model.selectedService.requirements);
            },
          ),
        ),
        onWillPop: () {
          Provider.of<ServiceProvider>(context, listen: false)
              .unselectService();
          return Future.value(true);
        },
      ),
    );
  }

  Widget _buildRequirements(List requirements) {
    return Column(
      children: requirements.map((requirement) {
        print(requirement['DescriptionEnglish']);
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
              leading: Icon(FontAwesomeIcons.checkSquare),
              title: Text(
                requirement['DescriptionEnglish'],
                style: Theme.of(context).textTheme.body1,
              )),
        );
      }).toList(),
    );
  }
}
