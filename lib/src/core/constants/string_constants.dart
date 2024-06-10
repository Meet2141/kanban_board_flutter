import 'package:kanban_flutter/src/app_state/app_state.dart';

///StringConstants - Strings Constants are defined here
class StringConstants {
  static const appName = 'Kanban Flutter';

  // //Error
  static const requestTimedOut = 'Request timed out';
  static const serverError = 'Server error';
  static const pleaseTryAgain = 'Please try again.';
  static const pleaseCheckInternet = 'Please Check Internet';
  static const internetConnectionLost = 'Internet connection lost. Please retry';
  static const errorMessage = 'Authentication failed, Please contact to admin for onBoarding!';
}

///Created typedef for Map<String, dynamic> (JSON File Type)
typedef JsonPayLoad = Map<String, dynamic>;

/// Global variable for AppState class
AppState appState = AppState();
