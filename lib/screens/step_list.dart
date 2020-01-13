import 'package:eicapp/models/step.dart';
import 'package:eicapp/providers/country_profile.dart';
import 'package:eicapp/screens/step.dart';
import 'package:eicapp/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StepListScreen extends StatefulWidget {
  static final String id = 'step_list_screen';
  @override
  State<StatefulWidget> createState() {
    return _StepListScreenState();
  }
}

class _StepListScreenState extends State<StepListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CountryProfileProvider>(context, listen: false)
        .fetchAllCountryProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context,
        title: "Steps",
      ),
      body: RefreshIndicator(
        child: _buildSteps(),
        onRefresh: () {
          return Provider.of<CountryProfileProvider>(context, listen: false)
              .fetchAllCountryProfiles();
        },
      ),
    );
  }

  Widget _buildSteps() {
    return Consumer<CountryProfileProvider>(
      builder: (context, step, child) {
        if (step.allSteps == null) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                title: Text(
                  step.allSteps[index].name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(Icons.navigate_next),
                onTap: () => _selectStep(step.allSteps[index]),
              ),
            );
          },
          itemCount: step.allSteps.length,
        );
      },
    );
  }

  void _selectStep(StepModel step) {
    Provider.of<CountryProfileProvider>(context, listen: false)
        .selectStep(step);
    Navigator.pushNamed(context, StepScreen.id);
  }
}
