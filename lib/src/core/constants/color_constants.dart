import 'package:flutter/material.dart';

///ColorConstants - Color Constants are defined here
class ColorConstants{
  static const primary = Color(0xff6D4ABE);
  static const lightPurple1 = Color(0xffCDB0FF);
  static const lightPurple2 = Color(0xffEDE3FE);
  static const toastSuccess = Color(0xffF6F0FF);
  static const toastFailure = Color(0xffFDDDD2);
  static const border = Color(0xffA1A4A9);
  static const divider = Color(0xffE6E6E7);
  static const btnBackground = Color(0xffB9B9BA);
  static const white = Colors.white;
  static const black = Colors.black;
  static const red = Colors.red;
  static const transparent = Colors.transparent;
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}