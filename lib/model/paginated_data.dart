import 'package:flutter/material.dart';



  
class PaginatedData extends DataTableSource {
  PaginatedData({required this.data});
  List<Map> data;
  @override
  DataRow? getRow(int index) {
      return DataRow(
        // selected: _selectedDatas.contains(jObj),
        onSelectChanged: (value) {},
        cells: [
          DataCell(Text(data[index]["AMOUNT"].toString())),
          DataCell(Text(data[index]["BILL_NAME"].toString())),
          DataCell(Text(data[index]["COMPANY_NAME"].toString())),
        ],
      );
    
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
