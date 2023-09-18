import 'package:flutter/material.dart';
import 'package:mess_nitc/Networking/network_post.dart';
import 'package:mess_nitc/database_data/student_data.dart';
import 'package:mess_nitc/screens/home_page.dart';
import 'package:mess_nitc/widgets/text_field.dart';
import 'package:mess_nitc/widgets/text_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String username;
  late String pass;
  var response;
  late SharedPreferences _prefs;

  bool isError = false;
  @override
  void initState() {
    _prefs = Provider.of<StudentData>(context, listen: false).sharedPreferences;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Image(
                    image: const AssetImage("assets/images/food.png"),
                    height: MediaQuery.of(context).size.height / 18,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 30),
                child: const Text(
                  "Hello, Welcome!",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
              ),
              TxtField(
                isError: isError,
                title: "Username",
                onChanged: (value) {
                  username = value!;
                },
                errorText: "Enter correct Username",
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 50,
              ),
              TxtField(
                isError: isError,
                title: "ddmmyyyy",
                onChanged: (value) {
                  pass = value!;
                },
                errorText: "Enter correct password",
                hideText: true,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 25,
              ),
              TxtButton(
                onPressed: () async {
                  if (username != null && pass != null) {
                      response =
                          await Networking(username: username, pass: pass)
                              .sendLoginRequest();
                    if (response != null) {
                      Provider.of<StudentData>(context, listen: false)
                          .addStudentdata(response);
                      await _prefs.setBool("isLogged", true);
                      await _prefs.setStringList("idNamePass", [response["student"]["_id"],username,pass]);
                      if (context.mounted) {
                        setState(() {
                          isError = false;
                        });
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomePage.id, (route) => false);
                      }
                    } else {
                      setState(() {
                        isError = true;
                      });
                    }
                  }
                  print("not connected");
                },
                title: 'Login',
              )
            ],
          ),
        ),
      ),
    );
  }
}
