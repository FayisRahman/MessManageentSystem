import 'package:flutter/material.dart';

class TableItem extends StatelessWidget {
  final String itemName;
  final bool isNeeded;
  TableItem(this.itemName, {this.isNeeded = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          itemName,
          style: TextStyle(
            fontWeight: isNeeded ? FontWeight.w600 : null,
          ),
        ),
      ),
    );
  }
}
