import 'package:flutter/material.dart';
import 'package:mess_nitc/database_data/student_statement_data.dart';
import 'package:mess_nitc/database_data/student_data.dart';
import 'package:mess_nitc/widgets/dashboard.dart';
import 'package:provider/provider.dart';
import '../widgets/table_widgets/data_table_items.dart';
import '../widgets/table_widgets/text_widget.dart';

class PrevItemScreen extends StatefulWidget {
  static const String id = "PrevItemScreen";
  const PrevItemScreen({super.key});

  @override
  State<PrevItemScreen> createState() => _PrevItemScreenState();
}

class _PrevItemScreenState extends State<PrevItemScreen> {
  List<DataRow> _dataTableRow = [];
  int _totalItemsPrice = 0;
  int itemAmount = 0;
  late Data data;
  void createTableRows() async {
    _totalItemsPrice = 0;
    _dataTableRow.clear();
    for (int i = 0; i < data.tableItem.length; i++) {
      itemAmount = data.itemPrice[i] * data.itemQuantity[i];
      _totalItemsPrice += itemAmount;
      _dataTableRow.add(
        DataRow(
          cells: [
            DataCell(Center(child: Text(data.tableItem[i]))),
            DataCell(Center(child: Text("${data.itemPrice[i]}"))),
            DataCell(Center(child: Text("${data.itemQuantity[i]}"))),
            DataCell(Center(child: Text("$itemAmount"))),
            DataCell(Center(child: Text(data.boughtDate[i]))),
          ],
        ),
      );
    }
    setState(() {
      _dataTableRow;
    });
  }

  @override
  void initState() {
    data = Provider.of<StudentData>(context, listen: false).data;
    createTableRows();
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Text(
              "Last 10 Items You Bought",
              style: TextStyle(fontSize: 20, fontFamily: "Poppins"),
            ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(fontSize: 16, title: "Overall Price"),
                  Txt(fontSize: 16, title: "Date")
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(fontSize: 16, title: ":"),
                  Txt(fontSize: 16, title: ":")
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(
                    fontSize: 16,
                    title: "${data.netAmount} ₹",
                    isRequired: true,
                  ),
                  Txt(fontSize: 16, title: data.generatedDate)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Table(
// columnWidths: const {
// 0: FlexColumnWidth(2),
// 1: FlexColumnWidth(0.1),
// 2: FlexColumnWidth(1),
// },
// children: [
// TableRow(children: [
// TableCell(
// child: Txt(fontSize: 15, title: "Overall Price"),
// ),
// TableCell(
// child: Txt(fontSize: 15, title: ":"),
// ),
// const TableCell(
// child: Center(
// child: Padding(
// padding: EdgeInsets.all(6.5),
// child: Text(
// "26 ₹",
// style: TextStyle(fontWeight: FontWeight.w700),
// ),
// ),
// ),
// ),
// ]),
// TableRow(children: [
// TableCell(
// child: Txt(fontSize: 15, title: "Date"),
// ),
// TableCell(
// child: Txt(fontSize: 15, title: ":"),
// ),
// TableCell(
// child: Center(
// child: Padding(
// padding: EdgeInsets.all(6.5),
// child: Text(
// "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
// style: TextStyle(fontWeight: FontWeight.w700),
// ),
// ),
// ),
// ),
// ]),
// ],
// ),
