import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Color colorText;
  final Color colorBackground;
  final Function()? onTap;

  const MyButton(
      {super.key,
      required this.text,
      required this.colorText,
      required this.colorBackground,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 250,
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: colorText,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
