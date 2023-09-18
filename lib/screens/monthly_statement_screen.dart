import 'package:flutter/material.dart';
import 'package:mess_nitc/widgets/dashboard.dart';
import 'package:mess_nitc/widgets/table_widgets/data_table_items.dart';
import 'package:mess_nitc/widgets/table_widgets/text_widget.dart';
import 'package:mess_nitc/database_data/student_statement_data.dart';
import 'package:provider/provider.dart';
import '../database_data/student_data.dart';

class MonthlyStatementScreen extends StatefulWidget {
  static const String id = "MonthlyStatementScreen";

  @override
  State<MonthlyStatementScreen> createState() => _MonthlyStatementScreenState();
}

class _MonthlyStatementScreenState extends State<MonthlyStatementScreen> {
  late Data data;

  List<DataRow> _dataTableRow = [];
  int itemAmount = 0;
  int _messAmount = 0;

  void createTableRows() async {
    _dataTableRow.clear();

    for (int i = 0; i < data.tableItem.length; i++) {
      itemAmount = data.itemPrice[i] * data.itemQuantity[i];
      _dataTableRow.add(
        DataRow(
          cells: [
            DataCell(Center(child: Text(data.tableItem[i]))),
            DataCell(Center(child: Text("${data.itemPrice[i]}"))),
            DataCell(Center(child: Text("${data.itemQuantity[i]}"))),
            DataCell(Center(child: Text("$itemAmount"))),
            DataCell(Center(child: Text("${data.boughtDate[i]}"))),
          ],
        ),
      );
    }
    setState(() {
      _dataTableRow;
    });
  }

  void createFinalResult() {
    _messAmount = data.totalDayInMess * data.messFeePerDay;
    data.finalDetails[2] = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Txt(
          fontSize: 15,
          title: "${data.totalDayInMess}",
          isRequired: true,
        ),
        Txt(
          fontSize: 15,
          title: "150 ₹",
          isRequired: true,
        ),
        Txt(
          fontSize: 15,
          title: "${data.messFeePerDay} ₹",
          isRequired: true,
        ),
        const SizedBox(
          height: 10,
        ),
        Txt(
          fontSize: 15,
          title: "${data.netAmount} ₹",
          isRequired: true,
        ),
      ],
    );
  }

  @override
  void initState() {
    data = Provider.of<StudentData>(context, listen: false).data;
    createTableRows();
    createFinalResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4EB),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashBoard(),
          Txt(
            fontSize: 20,
            title: "Monthly Statement",
            isNeeded: true,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 35,
                  border: TableBorder.all(),
                  columns: const [
                    DataColumn(label: DataTableItem(title: "Item")),
                    DataColumn(label: DataTableItem(title: "Price")),
                    DataColumn(label: DataTableItem(title: "Qnty")),
                    DataColumn(label: DataTableItem(title: "Amount")),
                    DataColumn(label: DataTableItem(title: "Date and Time")),
                  ],
                  rows: _dataTableRow,
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: data.finalDetails,
            ),
          ),
        ],
      ),
    );
  }
}
