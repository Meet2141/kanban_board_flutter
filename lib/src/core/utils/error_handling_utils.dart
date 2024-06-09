// ignore_for_file: avoid_dynamic_calls
import 'package:dio/dio.dart';
import 'package:seed_flutter/src/core/constants/string_constants.dart';
import 'package:seed_flutter/src/core/utils/toast_utils.dart';

class ErrorHandlingUtils {
  ///This global method handles errors faced during calling or converting api responses.
  static Future<void> errorHandlingUtils({required DioException error}) async {
    /// Sentry error report method
    if (error.type == DioExceptionType.badResponse) {
      // await Sentry.captureException(error);
    }

    /// Error Handling based on status codes
    switch (error.response?.statusCode) {
      case 302:
        showMessage(error: error);
        break;
      case 307:
      // get_x.Get.offNamed(RouteConstants.maintenanceScreen);
        break;
      case 400:
        showMessage(error: error);
        break;
      case 401:
        if ((error.response?.data?['message'] ?? '') == StringConstants.errorMessage &&
            error.response?.statusCode == 401) {
          // get_x.Get.offNamed(RouteConstants.noAccessApplication);
        } else {
          // await OktaLoginUtils.getAccessToken();
        }
        break;
      case 403:
        showMessage(error: error);
        break;
      case 404:
        showMessage(error: error);
        break;
      case 405:
        showMessage(error: error);
        break;
      case 408:
        showMessage(error: error, message: StringConstants.requestTimedOut);
        break;
      case 413:
        showMessage(error: error, message: StringConstants.serverError);
        break;
      case 422:
        showMessage(error: error, message: StringConstants.pleaseTryAgain);
        break;
      case 500:
      // get_x.Get.offNamed(RouteConstants.maintenanceRetryScreen);
        break;
      case 502:
      // get_x.Get.offNamed(RouteConstants.maintenanceRetryScreen);
        break;
      case 503:
      // get_x.Get.offNamed(RouteConstants.maintenanceRetryScreen);
        break;
      case 101010:
        showMessage(error: error, message: StringConstants.internetConnectionLost);
        break;
      default:
        try {
          if (error.response?.data != null && error.response?.data is Map<String, dynamic>) {
            showMessage(error: error);
          }
        } catch (e) {
          showMessage(error: error);
          rethrow;
        }
    }
  }

  /// This method shows error message based on the error response
  static void showMessage({required DioException error, String? message}) {
    if ((message ?? '').isNotEmpty) {
      ToastUtils.showFailed(message: message ?? StringConstants.pleaseTryAgain);
    } else if (error.response?.data != null) {
      if ((error.response?.data['message'] ?? '').isNotEmpty) {
        ToastUtils.showFailed(message: (error.response?.data['message'] ?? StringConstants.pleaseTryAgain));
      }
    }
  }
}
