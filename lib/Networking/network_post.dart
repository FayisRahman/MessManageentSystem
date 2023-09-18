import 'dart:convert';

import 'package:http/http.dart' as http;

class Networking {
  late http.Response response;
  String username;
  String pass;
  String uid;
  String dateRange;
  String noOfDays;
  String reason;

  Networking(
      {this.username = "",
      this.pass = "",
      this.uid = "",
      this.dateRange = "",
      this.noOfDays = "",
      this.reason = ""});

  Future<dynamic> sendLoginRequest() async {
    response = await http.post(
      Uri.parse("http://192.168.67.199:3001/auth/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "regNo": username,
        "dateOfBirth": pass,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("request failed with status code ${response.statusCode}");
      return -1;
    }
  }

  Future<dynamic> getRequest(String url) async {
    response = await http
        .get(Uri.parse("http://192.168.67.199:3001/students/$uid/$url"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return -1;
    }
  }

  Future<void> sendMessCut() async {
    await http.post(
      Uri.parse("http://192.168.67.199:3001/students/$uid/messcuts"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "dateRange": dateRange,
        "noOfDays": noOfDays,
        "reason": reason,
      }),
    );
  }
}
