import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:kanban_flutter/src/core/utils/encrypted_shared_preference_utils.dart';

class AppState {
  static final AppState _singleton = AppState._internal();

  factory AppState() {
    return _singleton;
  }

  AppState._internal();

  ///Shared Preference
  EncryptedSharedPreferencesUtils encryptedSharedPreferences = EncryptedSharedPreferencesUtils();

  ///PackageInfo
  PackageInfo? packageInfo;

  ///Data
  bool isLogin = true;

  ///De Bounce
  // final deBouncer = Debouncer(delay: const Duration(milliseconds: 1200));
  // final deBouncerScroll = Debouncer(delay: const Duration(milliseconds: 1000));

  /// Package Info like version
  Future<void> getVersionInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  /// Date Formatter
  String formatDateTime({required String dateTime, String format = 'dd MMM' 'yy'}) {
    if (dateTime.isEmpty) {
      return dateTime;
    }
    DateTime dateLocalDateTime = DateTime.parse(dateTime);
    var formatter = DateFormat(format);
    return formatter.format(dateLocalDateTime);
  }

  ///_selectDate - Method used to select data
  Future<DateTime> selectDate(BuildContext context) async {
    DateTime today = DateTime.now();
    DateTime selectedDate = today;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != today) {
        selectedDate = picked;
    }
    return selectedDate;
  }
}
