import 'package:flutter/material.dart';
import 'package:seed_flutter/src/core/utils/haptic_feedback_utils.dart';

/// GestureExtension is used for onTap widget in app
extension GestureExtension on Widget {
  Widget onPressedWithHaptic(VoidCallback onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        HapticFeedbackUtils.runHaptic();
        onTap.call();
      },
      child: this,
    );
  }

  Widget onPressedWithoutHaptic(VoidCallback onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onTap.call();
      },
      child: this,
    );
  }

  Widget onPanDownGesture(VoidCallback onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanDown: (_) {
        onTap.call();
      },
      child: this,
    );
  }
}
