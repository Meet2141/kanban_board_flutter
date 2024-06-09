import 'package:connectivity_plus/connectivity_plus.dart';

/// This file contains internet connectivity methods.
Future<bool> isInternetConnectivity() async {
  List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult
      .where((element) =>
  element == ConnectivityResult.mobile ||
      element == ConnectivityResult.wifi ||
      element == ConnectivityResult.ethernet ||
      element == ConnectivityResult.vpn)
      .isNotEmpty;
}
