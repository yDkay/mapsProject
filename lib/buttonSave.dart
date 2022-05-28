import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class buttonSave extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final Color inkColor;
  final String text;
  final IconData icon;
  double sizeW;
  double sizeH;

  buttonSave(
      {Key? key,
      required this.textColor,
      required this.backgroundColor,
      required this.borderColor,
      required this.inkColor,
      required this.text,
      required this.icon,
      required this.sizeW,
      required this.sizeH})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeW,
      height: sizeH,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 1.0)),
    );
  }
}
