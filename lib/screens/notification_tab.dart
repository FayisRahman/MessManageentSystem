import 'package:flutter/material.dart';
import 'package:mess_nitc/database_data/student_data.dart';
import 'package:mess_nitc/widgets/dashboard.dart';
import 'package:mess_nitc/widgets/item_card.dart';
import 'package:mess_nitc/widgets/mess_cut_request_status_card.dart';
import 'package:mess_nitc/widgets/table_widgets/text_widget.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  static const String id = "NotificationScreen";
  String status = "";
  Color color = Colors.black54;
  List<StatusCard> statusCard = [];
  int length = 0;

  String requestStatus(String status) {
    if (status == "pending") {
      color = Colors.deepOrange.shade400;
      return "Pending";
    } else if (status == "approved") {
      color = Colors.green.shade400;
      return "Approved";
    } else if (status == "rejected") {
      color = Color(0xFFFE0000);
      return "Declined";
    } else {
      color = Colors.transparent;
      return "null";
    }
  }

  List<StatusCard> createAllCards(StudentData studentData) {
    statusCard.clear();
    length = studentData.dateRange.length;
    for (int i = 0; i < length; i++) {
      statusCard.add(
        StatusCard(
            status: requestStatus(studentData.messCutStatus[i]),
            statusColor: color,
            dateRange: studentData.dateRange[i]),
      );
    }
    return statusCard;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4EB),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashBoard(
            isReqPage: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Txt(
                      fontSize: 26,
                      title: "Notifications",
                      isNeeded: true,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: createAllCards(
                          Provider.of<StudentData>(context, listen: false)),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
