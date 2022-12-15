import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomText extends StatelessWidget {
  CustomText(
      {this.color, this.text, this.fontSize, this.textAlign, this.fontWeight});

  String? text;
  Color? color;
  double? fontSize;
  TextAlign? textAlign;
  FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(
        fontSize: fontSize ?? context.textTheme.bodyLarge!.fontSize,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? Theme.of(context).primaryColor,
      ),
    );
  }
}
