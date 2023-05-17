import '/Constants/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onBtnPressed;

  RoundedButton({required this.btnText, required this.onBtnPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
          colors: [Color(0xFF5C3E96), Color(0xFF312861)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: MaterialButton(
        onPressed: onBtnPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        textColor: Color.fromARGB(255, 30, 166, 234),
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
