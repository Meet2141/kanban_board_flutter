import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:seed_flutter/src/core/constants/color_constants.dart';
import 'package:seed_flutter/src/core/constants/image_constants.dart';
import 'package:seed_flutter/src/core/extensions/gesture_extensions.dart';
import 'package:seed_flutter/src/core/extensions/image_extensions.dart';
import 'package:seed_flutter/src/core/widgets/text_widgets/text_widgets.dart';

/// ToastUtils class is used for toast in app.
class ToastUtils {
  static late Function() cancel;

  static void cancelToast() {
    cancel();
  }

  /// Show success toast
  static void showSuccess({required String message}) {
    cancel = BotToast.showCustomNotification(
      duration: const Duration(seconds: 2),
      toastBuilder: (cancelFunc) {
        return toastView(
          message: message,
          image: ImageConstants.icCheck,
          cardColor: ColorConstants.toastSuccess,
        );
      },
    );
  }

  /// Show Failed toast
  static void showFailed({required String message}) {
    cancel = BotToast.showCustomNotification(
      duration: const Duration(seconds: 2),
      toastBuilder: (cancelFunc) {
        return toastView(
          message: message,
          image: ImageConstants.icError,
          cardColor: ColorConstants.toastFailure,
        );
      },
    );
  }

  ///toastView - Display Toast View
  static Widget toastView({
    required String message,
    required String image,
    required Color cardColor,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Card(
        elevation: 5,
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image.getSVGImageHW(),
              const SizedBox(width: 10),
              Expanded(
                child: TextWidgets(
                  text: message,
                  style: const TextStyle(fontSize: 12, color: ColorConstants.black),
                  maxLine: 5,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
              (ImageConstants.icCancel)
                  .getSVGImageHW(height: 15, width: 15, color: ColorConstants.primary)
                  .onPressedWithoutHaptic(() {
                cancelToast();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
