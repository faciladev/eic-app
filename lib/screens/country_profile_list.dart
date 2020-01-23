import 'package:eicapp/models/country_profile.dart';
import 'package:eicapp/providers/country_profile.dart';
import 'package:eicapp/screens/country_profile.dart';
import 'package:eicapp/widgets/myListing.dart';
import 'package:eicapp/widgets/myappbar.dart';
import 'package:eicapp/widgets/page.dart';
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
    return Page(
      appBar: MyAppBar(
        context,
        title: "Country Profile",
      ),
      pageContent: RefreshIndicator(
        child: _buildSectors(),
        onRefresh: () {
          return Provider.of<CountryProfileProvider>(context, listen: false)
              .fetchAllCountryProfiles();
        },
      ),
    );
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
            List<Widget> widgets = [
              Flexible(
                child: Text(
                  countryProfile.allCountryProfiles[index].name,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ];
            return MyListing(
              widgets,
              myOnTap: () =>
                  _selectSector(countryProfile.allCountryProfiles[index]),
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
