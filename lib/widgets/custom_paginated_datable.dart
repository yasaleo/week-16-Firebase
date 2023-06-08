import 'package:flutter/material.dart';

import '../model/dummy_data.dart';
import '../model/paginated_data.dart';

class CustomPaginatedDataTAble extends StatefulWidget {
  const CustomPaginatedDataTAble({super.key});

  @override
  State<CustomPaginatedDataTAble> createState() => _CustomPaginatedDataTAbleState();
}

class _CustomPaginatedDataTAbleState extends State<CustomPaginatedDataTAble> {

    bool sorted = false;

  List<Map> _data = [...tableData];


  @override
  Widget build(BuildContext context) {
    return   PaginatedDataTable(
      sortAscending: sorted,
      sortColumnIndex: 0,
      columns: [
        DataColumn(
          label: const Text('AMOUNT'),
          onSort: (columnIndex, sortAscending) {
            setState(() {
              _data = sortList(
                data: _data,
                isAsc: sorted,
                key: 'AMOUNT',
              );
            });
            sorted = !sorted;
          },
        ),
        DataColumn(
          label: const Text('"BILL_NAME"'),
          onSort: (columnIndex, sortAscending) {},
        ),
        DataColumn(
          label: const Text('COMPANY_NAME'),
          onSort: (columnIndex, sortAscending) {},
        ),
      ],
      source: PaginatedData(data: _data),
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