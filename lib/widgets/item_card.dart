import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final ImageProvider foreGroundImage;
  String? title1;
  ItemCard(
      {super.key,
      required this.title,
      this.title1 = "",
      required this.onPressed,
      required this.foreGroundImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Color(0xFFEADBC8),
            elevation: 2,
            foregroundColor: Colors.black38),
        onPressed: onPressed,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: CircleAvatar(
                foregroundImage: foreGroundImage,
                backgroundColor: Color(0xFF102C57),
                radius: 30,
              ),
            ),
            Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: "Poppins",
                  ),
                ),
                Text(
                  title1!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: "Poppins",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
