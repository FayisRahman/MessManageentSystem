import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mess_nitc/database_data/student_data.dart';
import 'package:mess_nitc/screens/home_page.dart';
import 'package:mess_nitc/screens/login_screen.dart';
import 'package:mess_nitc/widgets/table_widgets/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../Networking/network_post.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = "LoadingScreen";
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late SharedPreferences _prefs;
  List<String> idNamePass = [];
  bool isLogged = false;
  var response;

  Future<void> initialise() async {
    _prefs = await SharedPreferences.getInstance();
    Provider.of<StudentData>(context, listen: false).getSharedPref(_prefs);
    isLogged = (_prefs.getBool("isLogged") ?? false)!;
    idNamePass = (_prefs.getStringList("idNamePass") ?? [])!;
    if (isLogged == true && idNamePass != []) {
      response = await Networking(username: idNamePass[1], pass: idNamePass[2])
          .sendLoginRequest();
      if (context.mounted) {
        if (response != -1) {
          Navigator.pushReplacementNamed(context, HomePage.id);
          Provider.of<StudentData>(context, listen: false)
              .addStudentdata(response);
        } else {
          Navigator.pushReplacementNamed(context, LoginScreen.id);
        }
      }
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    }
  }

  @override
  void initState() {
    initialise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/images/foodjump.gif"),
              ),
              Txt(fontSize: 16, title: "Getting Profile Data.Please wait..."),
            ],
          ),
        ),
      ),
    );
  }
}
