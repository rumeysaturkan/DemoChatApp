import 'package:chat_app/Themes/constants.dart';
import 'package:chat_app/widgets/CustomText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MessageBalloon extends StatelessWidget {
  MessageBalloon(
      {super.key,
      required this.text,
      required this.width,
      required this.color,
      required this.topLeft,
      required this.topRight,
      required this.alignment});
  String text;
  Color color;
  Radius topLeft;
  Radius topRight;
  double width;
  AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          constraints: BoxConstraints(maxWidth: width),
          decoration: BoxDecoration(
            color: color.withOpacity(0.8),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              topLeft: topLeft,
              topRight: topRight,
            ),
          ),
          child: Padding(
              padding: EdgeInsets.all(20),
              child: CustomText(
                text: text,
                fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
              )),
        ),
      ),
    );
  }
}
