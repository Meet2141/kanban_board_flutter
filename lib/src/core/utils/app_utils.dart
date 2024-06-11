import 'package:flutter/material.dart';

class AppUtils {
  static Future futureDelay({Duration? duration, int? seconds, required VoidCallback afterDelay}) async {
    await Future.delayed(duration ?? Duration(seconds: seconds ?? 2)).then((value) {
      afterDelay();
    });
  }
}

extension SizedBoxInt on int {
  Widget get sw => SizedBox(
        width: double.parse(toString()),
      );

  Widget get sh => SizedBox(
        height: double.parse(toString()),
      );
}
