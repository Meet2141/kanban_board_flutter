import 'package:flutter/material.dart';

///TextWidgets - Display TextWidgets of Application.
class TextWidgets extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int? maxLine;
  final TextOverflow? textOverflow;

  const TextWidgets({
    super.key,
    required this.text,
    required this.style,
    this.maxLine,
    this.textOverflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      maxLines: maxLine,
      overflow: textOverflow,
    );
  }
}
