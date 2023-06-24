import 'package:flutter/material.dart';
import 'package:tictactoe/utils/colors.dart';

class CustomeTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final bool isReadOnly;
  const CustomeTextField(
      {super.key,
      required this.controller,
      required this.hinttext,
      this.isReadOnly = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.blue,
          blurRadius: 5,
          spreadRadius: 2,
        )
      ]),
      child: TextField(
        readOnly: isReadOnly,
        controller: controller,
        decoration: InputDecoration(
          fillColor: bgColor,
          filled: true,
          hintText: hinttext,
        ),
      ),
    );
  }
}
