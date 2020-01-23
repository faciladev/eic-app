import 'package:eicapp/models/service.dart';
import 'package:eicapp/providers/service.dart';
import 'package:eicapp/screens/service.dart';
import 'package:eicapp/util/ui_builder.dart';
import 'package:eicapp/widgets/myListing.dart';
import 'package:eicapp/widgets/myappbar.dart';
import 'package:eicapp/widgets/page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceListScreen extends StatefulWidget {
  static final String id = 'service_list_screen';
  @override
  State<StatefulWidget> createState() {
    return _ServiceListScreenState();
  }
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ServiceProvider>(context, listen: false).fetchAllServices();
  }

  @override
  Widget build(BuildContext context) {
    return Page(
      appBar: MyAppBar(
        context,
        title: "Services",
      ),
      pageContent: RefreshIndicator(
        child: _buildServices(),
        onRefresh: () {
          return Provider.of<ServiceProvider>(context, listen: false)
              .fetchAllServices();
        },
      ),
    );
  }

  Widget _buildServices() {
    return Consumer<ServiceProvider>(
      builder: (context, service, child) {
        if (service.allServices == null) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            List<Widget> widgets = [
              Flexible(
                child: Text(
                  service.allServices[index].name,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ];
            return MyListing(
              widgets,
              myOnTap: () => _selectService(service.allServices[index]),
            );
          },
          itemCount: service.allServices.length,
        );
      },
    );
  }

  void _selectService(Service service) {
    Provider.of<ServiceProvider>(context, listen: false).selectService(service);
    Navigator.pushNamed(context, ServiceScreen.id);
  }
}
