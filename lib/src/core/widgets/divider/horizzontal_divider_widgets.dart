import 'package:flutter/material.dart';
import 'package:seed_flutter/src/core/constants/color_constants.dart';

class HorizontalDividerWidgets extends StatelessWidget {
  final double? height;
  final double? thickness;
  final Color? color;

  const HorizontalDividerWidgets({super.key, this.color, this.height, this.thickness});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height ?? 1,
      thickness: thickness ?? 1,
      color: color ?? ColorConstants.divider,
    );
  }
}