import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:kanban_flutter/src/core/constants/shared_pref_constants.dart';
import 'package:kanban_flutter/src/core/constants/string_constants.dart';
import 'package:kanban_flutter/src/core/model/base/res_base_model.dart';
import 'package:kanban_flutter/src/core/utils/error_handling_utils.dart';
import 'package:kanban_flutter/src/core/utils/internet_connectivity_utils.dart';
import 'package:kanban_flutter/src/core/utils/toast_utils.dart';

/// DioService class contains basic html request functions
/// like get, put and post.
class DioService {
  Dio _dio = Dio();
  String tag = '${StringConstants.appName} API:';
  CancelToken? _cancelToken;
  static final Dio mDio = Dio();

  static DioService get instance => DioService._internal();

  factory DioService({bool stripeAuth = false}) {
    return instance;
  }

  DioService._internal() {
    _dio = initApiServiceDio();
  }

  Dio initApiServiceDio() {
    _cancelToken = CancelToken();
    final baseOption = BaseOptions(
        receiveDataWhenStatusError: true,
        followRedirects: false,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        baseUrl: dotenv.env['BASE_URL'] ?? '');
    mDio.options = baseOption;
    final mInterceptorsWrapper = InterceptorsWrapper(
      onRequest: (options, handler) async {
        var accessToken = await appState.encryptedSharedPreferences.getString(SharedPrefConstants.token);
        if (accessToken.isNotEmpty) {
          try {
            bool hasExpired = JwtDecoder.isExpired(accessToken);

            if (hasExpired) {
              // final newAccessToken = await OktaLoginUtils.getAccessToken().catchError((onError) {
              //   tokenRefreshErrorHandling(onError, handler: handler, options: options);
              //   return null;
              // });
              // if (newAccessToken == null) {
              //   return;
              // }
              ///Replace accessToken with newAccessToken
              options.headers = {
                'Authorization': 'Bearer $accessToken',
                'Connection': 'keep-alive',
                'content-type': 'application/json',
              };
            } else {
              options.headers = {
                'Authorization': 'Bearer $accessToken',
                'Connection': 'keep-alive',
                'content-type': 'application/json',
              };
            }
          } catch (e) {
            if (e is FormatException) {
              //If there is token error then force logout if needed
              // appState.forceLogOutUser({'type': 'Invalid token'}, e);
            }
          }
        } else {
          handler.reject(DioException(requestOptions: options, type: DioExceptionType.cancel));
          return;
        }
        return handler.next(options);
      },
      onResponse: (e, handler) {
        return handler.next(e);
      },
      onError: (e, handler) async {
        return handler.next(e);
      },
    );
    mDio.interceptors.add(mInterceptorsWrapper);
    return mDio;
  }

  void cancelRequests({CancelToken? cancelToken}) {
    cancelToken == null ? _cancelToken!.cancel('Cancelled') : cancelToken.cancel();
  }

  Future<Response?> get({
    required String endUrl,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(JsonPayLoad)? onSuccess,
    void Function(ResBaseModel)? onError,
    bool isReturnResponse = false,
  }) async {
    if (!await isInternetConnectivity()) {
      ToastUtils.showFailed(message: StringConstants.pleaseCheckInternet);
      return null;
    }
    return await (_dio
        .get(
      endUrl,
      queryParameters: queryParameters,
      cancelToken: cancelToken ?? _cancelToken,
      options: options,
    )
        .then((value) {
      if (value.statusCode == HttpStatus.ok || value.statusCode == HttpStatus.created) {
        if (onSuccess != null) {
          onSuccess(value.data);
        }
      } else {
        if (onError != null) {
          onError(value.data);
        }
      }
      return value;
    })).catchError((e) async {
      if (e is DioException) {
        await ErrorHandlingUtils.errorHandlingUtils(error: e);
      }
      throw e;
    });
  }

  Future<Response?> put(
      {required String endUrl,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(void)? onSuccess,
      void Function(void)? onError}) async {
    if (!await isInternetConnectivity()) {
      ToastUtils.showFailed(message: StringConstants.pleaseCheckInternet);
      return null;
    }
    return await (_dio
        .put(
      endUrl,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken ?? _cancelToken,
      options: options,
    )
        .then((value) {
      if (value.statusCode == HttpStatus.ok || value.statusCode == HttpStatus.created) {
        if (onSuccess != null) {
          onSuccess(value.data);
        }
      } else {
        if (onError != null) {
          onError(value.data);
        }
      }
      return value;
    }).catchError((e) async {
      if (e is DioException) {
        await ErrorHandlingUtils.errorHandlingUtils(error: e);
      }
      throw e;
    }));
  }

  Future<Response?> post(
      {required String endUrl,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(ResBaseModel)? onSuccess,
      void Function(ResBaseModel)? onError}) async {
    if (!await isInternetConnectivity()) {
      ToastUtils.showFailed(message: StringConstants.pleaseCheckInternet);
      return null;
    }
    return await (_dio
        .post(
      endUrl,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken ?? _cancelToken,
      options: options,
    )
        .then((value) {
      if (value.statusCode == HttpStatus.ok || value.statusCode == HttpStatus.created) {
        if (onSuccess != null) {
          onSuccess(ResBaseModel.fromJson(value.data));
        }
      } else {
        if (onError != null) {
          onError(ResBaseModel.fromJson(value.data));
        }
      }
      return value;
    })).catchError((e) async {
      if (e is DioException) {
        await ErrorHandlingUtils.errorHandlingUtils(error: e);
      }
      throw e;
    });
  }

  Future<Response> postForm(
      {required String endUrl,
      FormData? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(ResBaseModel)? onSuccess,
      void Function(dynamic)? onError}) async {
    return await (_dio
        .post(
      endUrl,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken ?? _cancelToken,
      options: options,
    )
        .then((value) {
      if (value.statusCode == HttpStatus.ok || value.statusCode == HttpStatus.created) {
        if (onSuccess != null) {
          onSuccess(ResBaseModel.fromJson(value.data));
        }
      } else {
        if (onError != null) {
          onError(value.data);
        }
      }
      return value;
    })).catchError((e) async {
      if (e is DioException) {
        await ErrorHandlingUtils.errorHandlingUtils(error: e);
      }
      throw e;
    });
  }

  Future<Response?> patch({
    required String endUrl,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    if (!await isInternetConnectivity()) {
      ToastUtils.showFailed(message: StringConstants.pleaseCheckInternet);
      return null;
    }
    return await (_dio.patch(
      endUrl,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken ?? _cancelToken,
      options: options,
    )).catchError((e) async {
      if (e is DioException) {
        await ErrorHandlingUtils.errorHandlingUtils(error: e);
      }
      throw e;
    });
  }

  Future<Response?> delete({
    required String endUrl,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    if (!await isInternetConnectivity()) {
      ToastUtils.showFailed(message: StringConstants.pleaseCheckInternet);
      return null;
    }
    return await (_dio.delete(
      endUrl,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: options,
    )).catchError((e) async {
      if (e is DioException) {
        await ErrorHandlingUtils.errorHandlingUtils(error: e);
      }
      throw e;
    });
  }

  Future<Response?> multipartPost({
    required String endUrl,
    FormData? data,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    if (!await isInternetConnectivity()) {
      ToastUtils.showFailed(message: StringConstants.pleaseCheckInternet);
      return null;
    }
    return await (_dio.post(
      endUrl,
      data: data,
      cancelToken: cancelToken,
      options: options,
    )).catchError((e) async {
      if (e is DioException) {
        await ErrorHandlingUtils.errorHandlingUtils(error: e);
      }
      throw e;
    });
  }

  Future<Response?> getDownload({
    required String endUrl,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    if (!await isInternetConnectivity()) {
      ToastUtils.showFailed(message: StringConstants.pleaseCheckInternet);
      return null;
    }

    return await (_dio.get(
      endUrl,
      options: Options(
        headers: {
          'responseType': 'blob',
        },
        responseType: ResponseType.bytes,
      ),
      queryParameters: queryParameters,
      cancelToken: cancelToken ?? _cancelToken,
    )).catchError((e) async {
      if (e is DioException) {
        await ErrorHandlingUtils.errorHandlingUtils(error: e);
      }
      throw e;
    });
  }
}
