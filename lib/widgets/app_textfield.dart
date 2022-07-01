import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.keyboardType,
    this.hideText = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final bool hideText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 6.0, bottom: 6.0, left: 15, right: 15),
      child: TextField(
        obscureText: hideText,
        style: TextStyle(color: Colors.blueGrey),
        cursorColor: Colors.amber,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.amber),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
