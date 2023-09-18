import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import '../widgets/table_widgets/text_widget.dart';
import 'package:mess_nitc/Networking/network_post.dart';

class Data {
  List<String> tableItem = ["Lays", "Chips", "Snickers", "Lays"];
  List<int> itemPrice = [10, 20, 50, 10];
  List<int> itemQuantity = [2, 3, 5, 3];
  List<String> boughtDate = [];
  int messFeePerDay = 150;
  int totalDayInMess = 30;
  int netAmount = 0;
  String generatedDate = "";
  var response;
  List<dynamic> dataLogs = [];
  var monthlyData;
  var studentData;

  Future<void> getRequest(String uid, String url) async {
    response = await Networking(uid: uid).getRequest(url);
    if (response == -1) {
      print("No Data Available");
    } else {
      dataLogs.clear();
      tableItem.clear();
      itemPrice.clear();
      itemQuantity.clear();
      boughtDate.clear();
      dataLogs.addAll(
          (url == "monthly") ? response["monthlyLogs"] : response["logs"]);
      print(dataLogs);
      for (int i = 0; i < dataLogs.length; i++) {
        tableItem.add(dataLogs[i]["name"]);
        itemPrice.add(dataLogs[i]["price"]);
        itemQuantity.add(dataLogs[i]["quantity"]);
        boughtDate.add(dataLogs[i]["createdAt"]);
      }
      if (url == "monthly") {
        totalDayInMess = response["dayCount"];
        messFeePerDay = response["totalMessFee"];
      } else {
        generatedDate = response["date"];
      }
      netAmount = response["netAmount"];
    }
  }

  List<Column> finalDetails = [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Txt(fontSize: 15, title: "Total day mess used in this month"),
        Txt(fontSize: 15, title: "Mess fee per day"),
        Txt(fontSize: 15, title: "Total mess fee"),
        const SizedBox(
          height: 10,
        ),
        Txt(fontSize: 15, title: "Net Amount"),
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Txt(fontSize: 15, title: ":"),
        Txt(fontSize: 15, title: ":"),
        Txt(fontSize: 15, title: ":"),
        const SizedBox(
          height: 10,
        ),
        Txt(fontSize: 15, title: ":"),
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Txt(
          fontSize: 15,
          title: "26",
          isRequired: true,
        ),
        Txt(
          fontSize: 15,
          title: "150 ₹",
          isRequired: true,
        ),
        Txt(
          fontSize: 15,
          title: "3900 ₹",
          isRequired: true,
        ),
        const SizedBox(
          height: 10,
        ),
        Txt(
          fontSize: 15,
          title: "3955 ₹",
          isRequired: true,
        ),
      ],
    ),
  ];
}
