import 'package:flutter/services.dart';

/// HapticFeedbackUtils class is used to setup haptic feedback (vibration) on click events.
class HapticFeedbackUtils {
  static void runHaptic({int priority = 2}) {
    switch (priority) {
      case 0:
        HapticFeedback.lightImpact();
        break;
      case 1:
        HapticFeedback.mediumImpact();
        break;
      case 2:
        HapticFeedback.heavyImpact();
        break;
      default:
        HapticFeedback.mediumImpact();
    }
  }
}
