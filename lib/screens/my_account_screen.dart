import 'package:flutter/material.dart';
import 'package:mess_nitc/database_data/student_data.dart';
import 'package:mess_nitc/screens/login_screen.dart';
import 'package:mess_nitc/widgets/dashboard.dart';
import 'package:mess_nitc/widgets/table_widgets/text_widget.dart';
import 'package:mess_nitc/widgets/text_button.dart';
import 'package:provider/provider.dart';

class MyAccountScreen extends StatelessWidget {
  static const String id = "MyAccountScreen";

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentData>(
      builder: (context, studentData, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F4EB),
          body: Center(
            child: Column(
              children: [
                DashBoard(),
                const SizedBox(
                  height: 100,
                ),
                Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage(
                          "assets/images/acc.jpg",
                        ),
                        fit: BoxFit.fill),
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.height / 7,
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Txt(
                    title: "${studentData.studentData["name"]}",
                    fontSize: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Txt(
                              fontSize: 16,
                              title: "Reg.No",
                            ),
                            Txt(fontSize: 16, title: "Hostel"),
                            Txt(fontSize: 16, title: "Mess"),
                            Txt(fontSize: 16, title: "Room No."),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Txt(fontSize: 16, title: ":"),
                            Txt(fontSize: 16, title: ":"),
                            Txt(fontSize: 16, title: ":"),
                            Txt(fontSize: 16, title: ":"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Txt(
                                fontSize: 16,
                                title: "${studentData.studentData["regNo"]}"),
                            Txt(
                                fontSize: 16,
                                title: "${studentData.studentData["hostel"]}"),
                            Txt(
                                fontSize: 16,
                                title: "${studentData.studentData["roomNo"]}"),
                            Txt(
                                fontSize: 16,
                                title: "${studentData.studentData["mess"]}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                TxtButton(
                    onPressed: () async {
                      await Provider.of<StudentData>(context, listen: false)
                          .sharedPreferences
                          .setBool("isLogged", false);
                      await Provider.of<StudentData>(context, listen: false)
                          .sharedPreferences
                          .setStringList("idNamePass", []);
                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, LoginScreen.id, (route) => false);
                      }
                    },
                    title: "Sign Out")
              ],
            ),
          ),
        );
      },
    );
  }
}
