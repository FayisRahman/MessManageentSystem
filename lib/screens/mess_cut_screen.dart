import 'dart:core';
import 'package:flutter/material.dart';
import 'package:mess_nitc/Networking/network_post.dart';
import 'package:mess_nitc/screens/notification_tab.dart';
import 'package:mess_nitc/widgets/dashboard.dart';
import 'package:mess_nitc/widgets/mess_cut_text_field.dart';
import 'package:mess_nitc/widgets/text_button.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:provider/provider.dart';

import '../database_data/student_data.dart';

class MessCutScreen extends StatefulWidget {
  static const String id = "MessCutScreen";

  @override
  State<MessCutScreen> createState() => _MessCutScreenState();
}

class _MessCutScreenState extends State<MessCutScreen> {
  String dateFrom = "";

  String noOfDays = "";

  String reason = "";

  String dateRange = "";

  List<DateTime> dates = [];

  List<DateTime> dates1 = [];

  var response;
  var response1;

  final now = DateTime.now();

  final TextEditingController _controller1 = TextEditingController();

  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();

  void setDates(List<DateTime?>? date) {
    if (date?.length == 1) {
      dateRange = "${date?[0].toString().substring(0, 10)}";
      _controller2.text = "1";
    } else {
      dateRange =
          "${date?[0].toString().substring(0, 10)} to ${date?[1].toString().substring(0, 10)}";
      _controller2.text = date![1]!.difference(date[0]!).inDays.toString();
    }
    setState(() {
      _controller1.text = dateRange;
      _controller2.text;
      noOfDays = _controller2.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF6F4EB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DashBoard(),
            MessCutTextField(
              controller: _controller1,
              title: "Dates:",
              calendarRequired: true,
              onIconPressed: () async {
                var results = await showCalendarDatePicker2Dialog(
                  context: context,
                  config: CalendarDatePicker2WithActionButtonsConfig(
                    firstDate: DateTime(now.year, now.month, now.day + 2),
                    calendarType: CalendarDatePicker2Type.range,
                  ),
                  dialogSize: const Size(325, 400),
                  value: dates,
                  borderRadius: BorderRadius.circular(15),
                );
                setDates(results);
              },
            ),
            MessCutTextField(
              controller: _controller2,
              title: "No.of Days:",
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              child: TextField(
                controller: _controller3,
                onChanged: (value) {
                  reason = value;
                },
                maxLines: 20,
                maxLength: 500,
                decoration: const InputDecoration(
                  hintText: "Write your reason for mess cut...",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFDAC0A3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFDAC0A3),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: TxtButton(
              onPressed: () async {
                try {
                  await Networking(
                    dateRange: dateRange,
                    noOfDays: noOfDays.toString(),
                    reason: reason,
                    uid: Provider.of<StudentData>(context, listen: false)
                        .studentId,
                  ).sendMessCut();
                  response = await Networking(
                    uid: Provider.of<StudentData>(context, listen: false)
                        .studentId,
                  ).getRequest("messcuts");
                  setState(() {
                    _controller2.clear();
                    _controller1.clear();
                    _controller3.clear();
                  });
                } catch (e) {
                  print(e.toString());
                }
                if (context.mounted) {
                  Provider.of<StudentData>(context, listen: false)
                      .addNotifications(response);
                  Navigator.pushNamed(
                    context,
                    NotificationScreen.id,
                  );
                }
              },
              title: "Request Mess Cut",
              isChecked: false,
            ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
