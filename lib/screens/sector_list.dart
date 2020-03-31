import 'package:eicapp/models/sector.dart';
import 'package:eicapp/providers/sector.dart';
import 'package:eicapp/screens/sector.dart';
import 'package:eicapp/widgets/myListing.dart';
import 'package:eicapp/widgets/myappbar.dart';
import 'package:eicapp/widgets/page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectorListScreen extends StatefulWidget {
  static final String id = 'sector_list_screen';
  @override
  State<StatefulWidget> createState() {
    return _SectorListScreenState();
  }
}

class _SectorListScreenState extends State<SectorListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SectorProvider>(context, listen: false).fetchAllSectors();
  }

  @override
  Widget build(BuildContext context) {
    return Page(
      appBar: MyAppBar(
        context,
        title: "Sectors",
      ),
      // endDrawer: MyDrawer(),
      pageContent: RefreshIndicator(
        child: _buildSectors(),
        onRefresh: () {
          return Provider.of<SectorProvider>(context, listen: false)
              .fetchAllSectors();
        },
      ),
    );
  }

  Widget _buildSectors() {
    return Consumer<SectorProvider>(
      builder: (context, sector, child) {
        if (sector.allSectors == null) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            List<Widget> widgets = [
              Flexible(
                child: Text(
                  sector.allSectors[index].name,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ];
            return MyListing(
              widgets,
              myOnTap: () => _selectSector(sector.allSectors[index]),
            );
          },
          itemCount: sector.allSectors.length,
        );
      },
    );
  }

  void _selectSector(Sector sector) {
    Provider.of<SectorProvider>(context, listen: false).selectSector(sector);
    Navigator.pushNamed(context, SectorScreen.id);
  }
}
