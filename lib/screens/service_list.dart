import 'package:eicapp/models/service.dart';
import 'package:eicapp/providers/service.dart';
import 'package:eicapp/screens/service.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Services',
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.title.fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
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
            return Card(
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                title: Text(
                  service.allServices[index].name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(Icons.navigate_next),
                onTap: () => _selectService(service.allServices[index]),
              ),
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
