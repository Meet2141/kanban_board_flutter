import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:kanban_flutter/src/core/constants/animation_constants.dart';

///LoaderUtils - Used to display and dismiss loader
class LoaderUtils {
  static final LoaderUtils _instance = LoaderUtils.internal();
  static bool _isLoading = false;

  LoaderUtils.internal();

  factory LoaderUtils() => _instance;

  /// Dismiss loader
  static void dismissProgressDialog(BuildContext context) {
    if (_isLoading) {
      context.pop();
      _isLoading = false;
    }
  }

  static bool isProgressDialogOpen() {
    return _isLoading;
  }

  /// Show loader
  static Future<void> showProgressDialog(BuildContext context, {String? animation, bool isLottie = true}) async {
    _isLoading = true;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SimpleDialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          children: <Widget>[
            Center(
              child: isLottie
                  ? Lottie.asset(
                      animation ?? AnimationConstants.circularLoadingAnimation,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    )
                  : Image.asset(
                      animation ?? AnimationConstants.loadingAnimationGif,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
            ),
          ],
        );
      },
    );
  }
}
