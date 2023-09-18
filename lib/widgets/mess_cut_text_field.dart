import 'package:flutter/material.dart';

class MessCutTextField extends StatelessWidget {
  final String title;
  final bool calendarRequired;
  final VoidCallback? onIconPressed;
  final TextEditingController controller;
  MessCutTextField(
      {super.key,
      required this.title,
      this.calendarRequired = false,
      this.onIconPressed,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
      child: TextField(
        readOnly: true,
        controller: controller,
        onChanged: (value) {},
        decoration: InputDecoration(
          suffixIcon: calendarRequired
              ? IconButton(
                  onPressed: onIconPressed,
                  icon: const Icon(Icons.calendar_month))
              : null,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          labelText: title,
          border: const OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFDAC0A3)),
          ),
        ),
      ),
    );
  }
}
