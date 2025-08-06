import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextFild extends StatelessWidget {
  /// Custom Text Field for email input
  final String hintText;
  final bool obsecureText;
  const CustomTextFild({
    super.key,
    required this.hintText,
    this.obsecureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white54, width: 1.5),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white54),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        style: TextStyle(color: Colors.white),
        obscureText: obsecureText,
        obscuringCharacter: '★',
      ),
    );
  }
}
