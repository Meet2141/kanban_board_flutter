import 'package:seed_flutter/src/app_state/app_state.dart';

///StringConstants - Strings Constants are defined here
class StringConstants {
  static const appName = 'Seed Flutter';
  static const developerName = 'Meet Shah';
  static const by = 'by';
  static const home = 'Home';
  static const add = 'Add';
  static const cancel = 'Cancel';
  static const update = 'Update';
  static const welcome = 'Welcome!';
  static const addTask = 'Add Task';
  static const updateTask = 'Update Task';
  static const title = 'Title';
  static const description = 'Description';

  //Error
  static const requestTimedOut = 'Request timed out';
  static const serverError = 'Server error';
  static const connectTimedOut = 'Connect timed out';
  static const pleaseTryAgain = 'Please try again.';
  static const somethingWentWrong = 'Something Went Wrong';
  static const pleaseCheckInternet = 'Please Check Internet';
  static const internetConnectionLost = 'Internet connection lost. Please retry';
  static const errorMessage = 'Authentication failed, Please contact to admin for onBoarding!';
  static const pleaseEnterTitle = 'Please enter title';
  static const titleMustHaveTwoCharacters = 'Title must have atleast 2 characters';
  static const pleaseEnterDescription = 'Please enter description';
  static const descriptionMustHaveTwoCharacters = 'Description must have atleast 2 characters';
}

///Created typedef for Map<String, dynamic> (JSON File Type)
typedef JsonPayLoad = Map<String, dynamic>;

/// Global variable for AppState class
AppState appState = AppState();
