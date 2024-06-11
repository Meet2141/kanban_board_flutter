import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:kanban_flutter/src/core/constants/endpoint_constants.dart';
import 'package:kanban_flutter/src/core/constants/string_constants.dart';
import 'package:kanban_flutter/src/core/model/base/res_base_model.dart';
import 'package:kanban_flutter/src/service/dio_service.dart';

/// ApiService class is used to make server calls and return data in respective models.
class ApiService {
  static final ApiService instance = ApiService._internal();

  factory ApiService() {
    return instance;
  }

  ApiService._internal();

  JsonPayLoad getErrorModel(DioException error) {
    /// Set for unknown OneByteString error logged on sentry.
    JsonPayLoad? responseData;
    if (error.response?.data == null || error.response?.data is Map<String, dynamic>) {
      responseData = error.response?.data;
    }

    ResBaseModel baseModel = ResBaseModel.fromJson(responseData ??
        {
          'status': '${error.response?.statusCode}',
          'code': error.response?.statusCode,
          'message': error.response?.statusMessage,
          'detail': error.response?.data,
          'error': error.error.toString(),
          'error_type': error.type.toString(),
        });
    return baseModel.toJson();
  }

  /// Login
  Future<ResBaseModel?> getAuth() async {
    String fcmToken = '';
    String appVersion = '';
    String deviceModel = '';
    String osVersion = '';
    // await FirebaseMessaging.instance.getToken().then((value) => fcmToken = value ?? '');
    await appState.getVersionInfo();
    var deviceInfo = DeviceInfoPlugin();
    appVersion = appState.packageInfo?.version ?? '1.0.0';

    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceModel = iosDeviceInfo.name;
      osVersion = iosDeviceInfo.systemVersion;
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceModel = androidDeviceInfo.model;
      osVersion = androidDeviceInfo.version.release;
    }

    JsonPayLoad json = {
      'device_token': fcmToken,
      'os': Platform.isIOS ? 'ios' : 'android',
      'os_version': osVersion,
      'model': deviceModel,
      'app_version': appVersion,
      'tz': DateTime.now().timeZoneName,
    };

    try {
      final response = await DioService.instance.post(endUrl: EndpointConstants.auth, data: json);
      return response?.data != null ? ResBaseModel.fromJson(response?.data ?? {}) : null;
    } on DioException catch (error) {
      throw getErrorModel(error);
    }
  }
}
