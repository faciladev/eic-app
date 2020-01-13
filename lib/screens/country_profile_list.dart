import 'package:eicapp/models/country_profile.dart';
import 'package:eicapp/providers/country_profile.dart';
import 'package:eicapp/screens/country_profile.dart';
import 'package:eicapp/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryProfileListScreen extends StatefulWidget {
  static final String id = 'country_profile_list_screen';
  @override
  State<StatefulWidget> createState() {
    return _CountryProfileListScreenState();
  }
}

class _CountryProfileListScreenState extends State<CountryProfileListScreen> {
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
        title: "Country Profile",
      ),
      // endDrawer: MyDrawer(),
      body: RefreshIndicator(
        child: _buildSectors(),
        onRefresh: () {
          return Provider.of<CountryProfileProvider>(context, listen: false)
              .fetchAllCountryProfiles();
        },
      ),
    );
  }

  Widget _buildSectors() {
    return Consumer<CountryProfileProvider>(
      builder: (context, countryProfile, child) {
        if (countryProfile.allCountryProfiles == null) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.4, 0.8],
                  colors: <Color>[
                    Theme.of(context).primaryColor,
                    Theme.of(context).secondaryHeaderColor
                  ],
                ),
              ),
              child: ListTile(
                // contentPadding:
                //     EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                title: Text(
                  countryProfile.allCountryProfiles[index].name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                trailing: Icon(
                  Icons.navigate_next,
                  color: Colors.white,
                ),
                onTap: () =>
                    _selectSector(countryProfile.allCountryProfiles[index]),
              ),
            );
          },
          itemCount: countryProfile.allCountryProfiles.length,
        );
      },
    );
  }

  void _selectSector(CountryProfile countryProfile) {
    Provider.of<CountryProfileProvider>(context, listen: false)
        .selectCountryProfile(countryProfile);
    Navigator.pushNamed(context, CountryProfileScreen.id);
  }
}
