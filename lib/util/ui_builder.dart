import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

Widget buildNestedContent(dynamic root, BuildContext context) {
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

          List<DataColumn> dataColumns = buildDataColumns(headers, rows);
          List<DataRow> dataRows = buildDataRows(rows, headers);
          addTableToPage(body, dataColumns, dataRows);
        } else if (key == 'list') {
          List<Widget> children = buildListChildren(value);
          addListToPage(body, children);
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
          Widget textOrImage;
          if (stringData.toLowerCase().endsWith('.jpg') ||
              stringData.toLowerCase().endsWith('.jpeg') ||
              stringData.toLowerCase().endsWith('png') ||
              stringData.toLowerCase().endsWith('gif')) {
            textOrImage = Padding(
              padding: const EdgeInsets.all(8.0),
              child: FadeInImage.memoryNetwork(
                fit: BoxFit.cover,
                placeholder: kTransparentImage,
                image: stringData,
              ),
            );
          } else {
            textOrImage = Text(
              stringData,
              style: Theme.of(context).textTheme.body1,
            );
          }
          body.insert(
            0,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: textOrImage,
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

void addTableToPage(
    List<Widget> body, List<DataColumn> dataColumns, List<DataRow> dataRows) {
  //Check if table is empty
  if (dataColumns.length == 0 && dataRows.length == 0) {
    return;
  }

  //Check if rows are empty
  if (dataRows.length == 0 || dataRows[0].cells.length == 0) {
    return;
  }

  //Check if column size and cell size match
  //If there's a mismatch fill the lower one with empty text
  int maxCell = 0;
  for (DataRow dataRow in dataRows) {
    if (dataRow.cells.length > maxCell) {
      maxCell = dataRow.cells.length;
    }
  }

  //If there are no columns fill in empty text
  if (dataColumns.length == 0) {
    for (int i = 0; i < maxCell; i++) {
      dataColumns.add(DataColumn(label: Text('')));
    }
  } else if (dataColumns.length < maxCell) {
    for (int i = 0; i < (maxCell - dataColumns.length); i++) {
      dataColumns.add(DataColumn(label: Text('')));
    }
  } else if (dataColumns.length > maxCell) {
    for (int i = 0; i < (dataColumns.length - maxCell); i++) {
      for (DataRow dataRow in dataRows) {
        if (dataRow.cells.length < dataColumns.length) {
          for (int i = 0;
              i < (dataColumns.length - dataRow.cells.length);
              i++) {
            dataRow.cells.add(DataCell(Text('')));
          }
        }
      }
    }
  }

  body.insert(
    0,
    PaginatedDataTable(
      rowsPerPage: dataRows.length <= 10
          ? dataRows.length
          : PaginatedDataTable.defaultRowsPerPage,
      columns: dataColumns,
      header: Container(),
      source: EicTableSource(rows: dataRows),
    ),
  );

  // PaginatedDataTable(
  //   columns: dataColumns,
  //   header: Container(),
  //   source: EicTableSource(rows: dataRows),
  // );

  _buildVerticalSpace(body);
}

void addListToPage(List<Widget> body, List<Widget> children) {
  body.insert(0, Column(children: children));
  _buildVerticalSpace(body);
}

void _buildVerticalSpace(List<Widget> body) {
  body.insert(
    0,
    SizedBox(
      height: 17.0,
    ),
  );
}

List<Widget> buildListChildren(value) {
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

List<DataRow> buildDataRows(List rows, List headers) {
  List<DataRow> dataRows = [];
  if (rows != null &&
      headers != null &&
      rows.length > 0 &&
      headers.length > 0) {
    for (int num = 0; num < rows.length; num++) {
      List<DataCell> dataCells = [];
      if (rows[num].length != headers.length) {
        // print('<Headers>');
        // print(headers);
        // print('</Headers>');
        // print('<Rows>');
        // print(rows[num]);
        // print('</Rows>');
        if (rows[num].length > headers.length) {
          headers = _equalizeRows(headers, rows[num]);
        } else {
          rows[num] = _equalizeRows(rows[num], headers);
        }

        //row and column length not equal
        // continue;
      }
      rows[num].forEach((cell) {
        dataCells.add(DataCell(Text(cell)));
      });
      dataRows.add(DataRow(cells: dataCells));
    }
  }
  return dataRows;
}

List _equalizeRows(List listToPopulate, List overflowList) {
  // print('<Overflow>');
  // print(overflowList);
  // print('</Overflow>');
  // print('<pre-populate>');
  // print(listToPopulate);
  // print('</pre-populate>');
  for (int count = 0;
      count < (overflowList.length - listToPopulate.length);
      count++) {
    listToPopulate.add("");
  }
  // print('<post-populate>');
  // print(listToPopulate);
  // print('</post-populate>');
  return listToPopulate;
}

List<DataColumn> buildDataColumns(List headers, List rows) {
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

class EicTableSource extends DataTableSource {
  final List<DataRow> rows;

  EicTableSource({this.rows});

  @override
  DataRow getRow(int index) {
    return rows[index];
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => rows.length;

  @override
  int get selectedRowCount => 0;
}
