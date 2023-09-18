import 'package:flutter/material.dart';
import 'package:mess_nitc/database_data/student_data.dart';
import 'package:mess_nitc/screens/loading_screen.dart';
import 'package:mess_nitc/screens/mess_cut_screen.dart';
import 'package:mess_nitc/screens/my_account_screen.dart';
import 'package:mess_nitc/screens/notification_tab.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_page.dart';
import 'screens/monthly_statement_screen.dart';
import 'screens/prev_items_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StudentData>(
      create: (context) => StudentData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoadingScreen.id,
        routes: {
          LoadingScreen.id: (context) => LoadingScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          HomePage.id: (context) => HomePage(),
          MonthlyStatementScreen.id: (context) => MonthlyStatementScreen(),
          PrevItemScreen.id: (context) => PrevItemScreen(),
          MyAccountScreen.id: (context) => MyAccountScreen(),
          MessCutScreen.id: (context) => MessCutScreen(),
          NotificationScreen.id: (context) => NotificationScreen(),
        },
      ),
    );
  }
}
