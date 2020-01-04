import 'package:eicapp/providers/country_profile.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Consumer<CountryProfileProvider>(
          builder: (context, model, _) {
            return Text(
              model.selectedCountryProfile.name,
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            model.selectedCountryProfile.name,
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                        _buildNestedContent(
                            model.selectedCountryProfile.content)
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
      ),
    );
  }

  Widget _buildNestedContent(dynamic root) {
    if (root == null) return Container();

    List nodeStack = [];
    List<Widget> body = [];
    try {
      Map<String, dynamic> mapData = root;
      mapData.forEach((String key, dynamic value) {
        nodeStack.add('__title__$key');
        nodeStack.add(value);
        nodeStack.add('__divider__');
      });
    } catch (e) {
      List<dynamic> listData = root;
      listData.forEach((item) {
        nodeStack.add(item);
      });
    }

    while (nodeStack.length > 0) {
      var node = nodeStack.removeLast();
      try {
        //check if node is a dictionary
        Map<String, dynamic> mapData = node;

        mapData.forEach((String key, dynamic value) {
          if (key == 'table') {
            List rows = value['rows'];
            List headers = value['headers'];
            List<DataColumn> dataColumns = _buildDataColumns(headers, rows);
            List<DataRow> dataRows = _buildDataRows(rows, headers);
            _addTableToPage(body, dataColumns, dataRows);
            _buildVerticalSpace(body);
          } else if (key == 'list') {
            List<Widget> children = _buildListChildren(value);
            _addListToPage(body, children);
            _buildVerticalSpace(body);
          } else {
            nodeStack.add('__title__$key');
            nodeStack.add(value);
            nodeStack.add('__divider__');
          }
        });
      } catch (e) {
        try {
          //Check if node is a List
          List<dynamic> listData = node;
          listData.forEach((item) {
            nodeStack.add(item);
          });
        } catch (e) {
          //Check if node is a String
          String stringData = node;

          if (stringData.startsWith('__title__')) {
            stringData = stringData.replaceFirst('__title__', '');
            if (stringData == 'text' ||
                stringData == 'images' ||
                stringData == 'lists' ||
                stringData == 'tables' ||
                stringData == 'content') {
              continue;
            }
            body.insert(
                0,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    stringData,
                    style: Theme.of(context).textTheme.title,
                  ),
                ));
          } else if (stringData.startsWith('__divider__')) {
            body.insert(
                0,
                SizedBox(
                  height: 17.0,
                ));
          } else {
            body.insert(
              0,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  stringData,
                  style: TextStyle(
                    fontFamily: Theme.of(context).textTheme.title.fontFamily,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }
        }
      }
    }

    return body.length > 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: body,
          )
        : Container();
  }

  void _addTableToPage(
      List<Widget> body, List<DataColumn> dataColumns, List<DataRow> dataRows) {
    body.insert(
      0,
      DataTable(
        columnSpacing: 5.0,
        columns: dataColumns.length <= 0
            ? [DataColumn(label: Text(''))]
            : dataColumns,
        rows: dataRows.length <= 0
            ? [
                DataRow(cells: [DataCell(Text(''))])
              ]
            : dataRows,
      ),
    );
  }

  void _addListToPage(List<Widget> body, List<Widget> children) {
    body.insert(0, Column(children: children));
  }

  void _buildVerticalSpace(List<Widget> body) {
    body.insert(
      0,
      SizedBox(
        height: 17.0,
      ),
    );
  }

  List<Widget> _buildListChildren(value) {
    List<dynamic> lists = value;
    List<Widget> children = lists.map((list) {
      return ListTile(
        leading: Icon(
          Icons.check_circle,
          size: 20.0,
        ),
        title: Text(
          list,
        ),
      );
    }).toList();
    return children;
  }

  List<DataRow> _buildDataRows(List rows, List headers) {
    List<DataRow> dataRows = [];
    if (rows != null &&
        headers != null &&
        rows.length > 0 &&
        headers.length > 0) {
      for (int num = 0; num < rows.length; num++) {
        List<DataCell> dataCells = [];
        if (rows[num].length != headers.length) {
          //row and column length not equal
          continue;
        }
        rows[num].forEach((cell) {
          dataCells.add(DataCell(Text(cell)));
        });
        dataRows.add(DataRow(cells: dataCells));
      }
    }
    return dataRows;
  }

  List<DataColumn> _buildDataColumns(List headers, List rows) {
    List<DataColumn> dataColumns = [];
    if (headers != null &&
        rows != null &&
        headers.length > 0 &&
        rows.length > 0) {
      dataColumns = headers.map((header) {
        return DataColumn(label: Text(header));
      }).toList();
    }
    return dataColumns;
  }
}
