import 'package:flutter/material.dart';

class DataTableItem extends StatelessWidget {
  final String title;

  const DataTableItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
