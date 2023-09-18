import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final String status;
  final Color statusColor;
  final String dateRange;
  const StatusCard(
      {super.key,
      required this.status,
      required this.statusColor,
      required this.dateRange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xFFFFD9B7),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Mess Cut Request Status",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                Text(
                  dateRange,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 25,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
