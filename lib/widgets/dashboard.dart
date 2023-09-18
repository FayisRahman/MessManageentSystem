import 'package:flutter/material.dart';
import 'package:mess_nitc/screens/notification_tab.dart';
import 'package:provider/provider.dart';

import '../Networking/network_post.dart';
import '../database_data/student_data.dart';

class DashBoard extends StatelessWidget {
  final bool isReqPage;
  DashBoard({super.key, this.isReqPage = false});
  var response;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      color: const Color(0xFFEEE0C9),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 17.0, left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 20,
              ),
              const Text(
                "MESS NITC",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.black38,
                ),
              ),
              !isReqPage
                  ? IconButton(
                      onPressed: () async {
                        response = await Networking(uid: Provider.of<StudentData>(context, listen: false)
                            .studentId,).getRequest("messcuts");
                        if(context.mounted) {
                          Provider.of<StudentData>(context, listen: false)
                              .addNotifications(response);
                          Navigator.pushNamed(
                            context,
                            NotificationScreen.id,
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.notifications_none,
                        color: Colors.black54,
                      ),
                    )
                  : const SizedBox(
                      width: 20,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
