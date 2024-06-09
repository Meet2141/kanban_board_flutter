import 'package:flutter/material.dart';
import 'package:kanban_flutter/src/core/constants/color_constants.dart';

///BottomSheetUtils class contain bottomSheet method used in app
class BottomSheetUtils {
  /// General Bottom sheet
  static Future<dynamic> bottomSheet({
    required BuildContext context,
    required WidgetBuilder widgetBuilder,
    bool isDismissible = true,
  }) async {
    return await showModalBottomSheet(
      context: context,
      backgroundColor: ColorConstants.white,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: isDismissible,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      builder: widgetBuilder,
    );
  }
}
