import 'package:flutter/cupertino.dart';
import 'package:mess_nitc/database_data/student_statement_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentData extends ChangeNotifier {
  Data data = Data();

  String studentId = "";

  late SharedPreferences sharedPreferences;

  List<String> dateRange = [];

  List<String> messCutStatus = [];

  var studentData;

  void addStudentdata(dynamic studentsData) {
    studentData = studentsData["student"];
    studentId = studentData["_id"];
    notifyListeners();
  }

  void getSharedPref(SharedPreferences sharedPref) {
    sharedPreferences = sharedPref;
  }

  void addNotifications(List<dynamic> notifications) {
    dateRange.clear();
    messCutStatus.clear();
    for (int i = 0; i < notifications.length; i++) {
      dateRange.add(notifications[i]["dateOfRange"]);
      messCutStatus.add(notifications[i]["status"]);
    }
  }
}
