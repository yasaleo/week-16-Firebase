import 'package:flutter/material.dart';

import '../model/dummy_data.dart';

class SortingDataTable extends StatefulWidget {
  const SortingDataTable({super.key});

  @override
  State<SortingDataTable> createState() => _SortingDataTableState();
}

class _SortingDataTableState extends State<SortingDataTable> {
  bool sorted = false;
  final List<Map> _selectedDatas = [];
  List<Map> _data = [...tableData];
  List<String> keys = tableData.first.keys.toList();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var myColumns = [
      DataColumn(
        label: const Text('name'),
        onSort: (columnIndex, sortAscending) {
          setState(() {
            index = columnIndex;
            _data =
                sortList(data: _data, isAsc: sorted, key: keys[columnIndex]);
            sorted = !sorted;
          });
        },
      ),
      DataColumn(
        label: const Text('age'),
        onSort: (columnIndex, sortAscending) {
          setState(() {
            index = columnIndex;
            _data =
                sortList(data: _data, isAsc: sorted, key: keys[columnIndex]);
            sorted = !sorted;
          });
        },
      ),
      DataColumn(
        label: Row(
          children: [
            const Text('Height'),
            const SizedBox(
              width: 20,
            ),
            PopupMenuButton(
              icon: const Icon(Icons.filter_alt),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Column(
                      children: [
                        SizedBox(
                          width: getSize(context).width / 2.5,
                          child: TextFormField(
                            decoration:
                                const InputDecoration(hintText: "Search"),
                          ),
                        ),
                        SizedBox(
                          width: getSize(context).width / 2.5,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black26,
                            ),
                            onPressed: () {
                              
                            },
                            child: const Text(
                              "Search",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        onSort: (columnIndex, sortAscending) {
          index = columnIndex;
          setState(() {
            _data = sortList(
              data: _data,
              isAsc: sorted,
              key: keys[columnIndex],
            );
            sorted = !sorted;
          });
        },
      ),
    ];

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.black26),
            border: TableBorder.symmetric(
              outside: const BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            columns: myColumns,
            rows: getRow(),
            sortColumnIndex: index,
            sortAscending: sorted,
          ),
        ),
      ),
    );
  }

  getRow() {
    List<DataRow> dataRow = [];
    for (var jObj in _data) {
      dataRow.add(
        DataRow(
          selected: _selectedDatas.contains(jObj),
          onSelectChanged: (value) {
            setState(() {
              if (_selectedDatas.contains(jObj)) {
                _selectedDatas.remove(jObj);
              } else {
                _selectedDatas.add(jObj);
              }
            });
          },
          cells: [
            DataCell(Text(jObj["AMOUNT"].toString())),
            DataCell(Text(jObj["BILL_NAME"].toString())),
            DataCell(Text(jObj["COMPANY_NAME"].toString())),
          ],
        ),
      );
    }
    return dataRow;
  }

  Widget sortButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          _data = sortList(data: _data, isAsc: sorted, key: 'INV_NAME');
        });

        sorted = !sorted;
      },
      child: const Text(
        "Sort here",
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),
      ),
    );
  }

  Widget testButtton() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.check_circle),
    );
  }

  List<Map> sortList(
      {required List<Map> data, required bool isAsc, required String key}) {
    assert(key != "");
    if (isAsc) {
      data = data.reversed.toList();
      // print(data);
      return data;
    } else {
      setState(
        () {
          data.sort(
            (a, b) => a[key].toString().compareTo(
                  b[key].toString(),
                ),
          );
          // print(_data.length);
        },
      );
    }
    return data;
  }
}

Size getSize(BuildContext context) {
  return MediaQuery.of(context).size;
}
