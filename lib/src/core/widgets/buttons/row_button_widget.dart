import 'package:flutter/material.dart';
import 'package:kanban_flutter/src/core/constants/color_constants.dart';
import 'package:kanban_flutter/src/core/constants/string_constants.dart';
import 'package:kanban_flutter/src/core/widgets/buttons/button_widget.dart';

///RowButtonWidgets - Display Row Button Widgets
class RowButtonWidgets extends StatelessWidget {
  final bool isValidNext;
  final String nxtBtnName;
  final VoidCallback nextTap;
  final String cancelBtnName;
  final VoidCallback cancelTap;

  const RowButtonWidgets({
    super.key,
    required this.isValidNext,
    this.nxtBtnName = StringConstants.add,
    required this.nextTap,
    this.cancelBtnName = StringConstants.cancel,
    required this.cancelTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ButtonWidgets(
          onTap: cancelTap,
          btnName: cancelBtnName,
          height: 40,
          borderColor: ColorConstants.primary,
          btnColor: ColorConstants.white,
          txtColor: ColorConstants.primary,
        ),
        const SizedBox(width: 20),
        ButtonWidgets(
          onTap: nextTap,
          btnName: nxtBtnName,
          height: 40,
          borderColor: isValidNext ? ColorConstants.primary : ColorConstants.btnBackground,
          btnColor: isValidNext ? ColorConstants.primary : ColorConstants.btnBackground,
          txtColor: ColorConstants.white,
        ),
      ],
    );
  }
}
