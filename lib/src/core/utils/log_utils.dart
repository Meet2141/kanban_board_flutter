import 'package:flutter/cupertino.dart';

/// LogUtils class is used to display logs.
/// This class helps to enable/disable logs of whole
/// application in single change.
class LogUtils {
  static void print(dynamic text) {
    debugPrint(text);
  }
}
