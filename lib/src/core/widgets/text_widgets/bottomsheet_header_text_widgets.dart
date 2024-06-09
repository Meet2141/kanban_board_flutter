import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seed_flutter/src/core/constants/color_constants.dart';
import 'package:seed_flutter/src/core/constants/image_constants.dart';
import 'package:seed_flutter/src/core/extensions/gesture_extensions.dart';
import 'package:seed_flutter/src/core/extensions/image_extensions.dart';
import 'package:seed_flutter/src/core/extensions/scaffold_extension.dart';
import 'package:seed_flutter/src/core/widgets/divider/horizzontal_divider_widgets.dart';
import 'package:seed_flutter/src/core/widgets/text_widgets/text_Widgets.dart';

///BottomSheetHeaderTextWidgets - Displays BottomSheet Header Text Widgets.
class BottomSheetHeaderTextWidgets extends StatelessWidget {
  final String header;
  final VoidCallback onBack;

  const BottomSheetHeaderTextWidgets({
    super.key,
    required this.header,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Row(
          children: [
            TextWidgets(
              text: header,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            ImageConstants.icCancel
                .getSVGImageHW(color: ColorConstants.black, width: 20, height: 20)
                .onPressedWithoutHaptic(() {
              onBack();
              context.pop();
            }),
          ],
        ).bodyPadding(),
        const SizedBox(height: 12),
        const HorizontalDividerWidgets(),
        const SizedBox(height: 12),
      ],
    );
  }
}
