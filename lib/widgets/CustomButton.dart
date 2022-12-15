import 'package:chat_app/Themes/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.onPressed, required this.text});
  VoidCallback onPressed;
  String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: purple),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
    );
  }
}
