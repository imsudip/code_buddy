import 'package:code_editor/constants/utils.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPress;
  final Color textColor, backgroundColor;
  const CustomButton(
      {Key key,
      this.title,
      this.icon,
      this.onPress,
      this.textColor,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        10.widthBox,
        Icon(icon, color: textColor),
      ],
    )
        .px16()
        .box
        .color(backgroundColor)
        .px16
        .py8
        .border(color: textColor.withOpacity(0.2))
        .customRounded(BorderRadius.circular(12))
        .make()
        .onTap(() {
      this.onPress();
    });
  }
}
