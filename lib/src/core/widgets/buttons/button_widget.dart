import 'package:flutter/material.dart';
import 'package:seed_flutter/src/core/constants/color_constants.dart';
import 'package:seed_flutter/src/core/extensions/gesture_extensions.dart';
import 'package:seed_flutter/src/core/widgets/text_widgets/text_Widgets.dart';

///ButtonWidgets - Display Button Widgets
class ButtonWidgets extends StatelessWidget {
  final String? btnName;
  final VoidCallback onTap;
  final Color? btnColor;
  final Color? txtColor;
  final Color? borderColor;
  final double? height;
  final Widget? child;

  const ButtonWidgets({
    super.key,
    this.btnName,
    required this.onTap,
    this.btnColor,
    this.borderColor,
    this.txtColor,
    this.height,
    this.child,
  }) : assert(btnName != null || child != null);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: height ?? 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: btnColor ?? ColorConstants.primary,
            border: Border.all(width: 1, color: borderColor ?? ColorConstants.transparent)),
        child: btnName != null
            ? TextWidgets(
                text: btnName ?? '',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: txtColor ?? ColorConstants.black,
                ),
              )
            : child,
      ).onPressedWithoutHaptic(() {
        onTap();
      }),
    );
  }
}
