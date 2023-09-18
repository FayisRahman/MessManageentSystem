import 'package:flutter/material.dart';
import 'package:mess_nitc/Networking/network_post.dart';
import 'package:mess_nitc/database_data/student_statement_data.dart';
import 'package:mess_nitc/database_data/student_data.dart';
import 'package:mess_nitc/screens/mess_cut_screen.dart';
import 'package:mess_nitc/screens/monthly_statement_screen.dart';
import 'package:mess_nitc/screens/my_account_screen.dart';
import 'package:mess_nitc/screens/prev_items_screen.dart';
import 'package:mess_nitc/widgets/dashboard.dart';
import 'package:mess_nitc/widgets/item_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String id = "homePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Data data;
  late String studentId;
  String walletBalance = "Rs 22000/-";
  String value = "";
  var response1;
  Future<void> getfunction() async {
    response1 = await Networking(
            username: Provider.of<StudentData>(context, listen: false)
                .sharedPreferences
                .getStringList("idNamePass")![1],
            pass: Provider.of<StudentData>(context, listen: false)
                .sharedPreferences
                .getStringList("idNamePass")![2])
        .sendLoginRequest();
    Provider.of<StudentData>(context, listen: false).addStudentdata(response1);
  }

  @override
  void initState() {
    data = Provider.of<StudentData>(context, listen: false).data;
    studentId = Provider.of<StudentData>(context, listen: false).studentId;
    walletBalance = "";
    walletBalance =
        "Rs ${Provider.of<StudentData>(context, listen: false).studentData["balance"]}/-";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF6F4EB),
      body: Column(
        children: [
          DashBoard(),
          const SizedBox(
            height: 20,
          ),
          ItemCard(
            foreGroundImage: AssetImage("assets/images/month.png"),
            title: "Monthly Statement",
            onPressed: () async {
              await data.getRequest(studentId, "monthly");
              Navigator.pushNamed(context, MonthlyStatementScreen.id);
              await getfunction();
              walletBalance =
                  "Rs ${Provider.of<StudentData>(context, listen: false).studentData["balance"]}/-";
              setState(() {
                walletBalance;
              });
            },
          ),
          ItemCard(
            foreGroundImage: AssetImage("assets/images/prevBill.png"),
            title: "Last 10 items You",
            title1: "bought",
            onPressed: () async {
              await data.getRequest(studentId, "last10");
              Navigator.pushNamed(context, PrevItemScreen.id);
              await getfunction();
              walletBalance =
                  "Rs ${Provider.of<StudentData>(context, listen: false).studentData["balance"]}/-";
              setState(() {
                walletBalance;
              });
            },
          ),
          ItemCard(
            foreGroundImage: AssetImage("assets/images/request.png"),
            title: "Request Mess Cut",
            onPressed: () async {
              Navigator.pushNamed(context, MessCutScreen.id);
              await getfunction();
              walletBalance =
                  "Rs ${Provider.of<StudentData>(context, listen: false).studentData["balance"]}/-";
              setState(() {
                walletBalance;
              });
            },
          ),
          ItemCard(
            foreGroundImage: AssetImage("assets/images/selfAcc.png"),
            title: "My Account",
            onPressed: () async {
              Navigator.pushNamed(context, MyAccountScreen.id);
              await getfunction();
              walletBalance =
                  "Rs ${Provider.of<StudentData>(context, listen: false).studentData["balance"]}/-";
              setState(() {
                walletBalance;
              });
            },
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xFFEEE0C9),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "My Wallet: ",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      walletBalance,
                      style: TextStyle(
                        color: walletBalance.startsWith("-", 3)
                            ? Colors.red
                            : Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
