class ResBaseModel {
  ResBaseModel({
    this.status,
    this.code,
    this.message,
    this.detail,
    this.error,
    this.errorType,
  });

  String? status;
  int? code;
  String? message;
  dynamic detail;
  String? error;
  String? errorType;

  factory ResBaseModel.fromJson(Map<String, dynamic> json) => ResBaseModel(
    status: json['status'],
    code: json['code'],
    message: json['message'] ?? '',
    detail: json['detail'],
    error: json['error'],
    errorType: json['error_type'],
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'code': code,
    'message': message,
    'detail': detail,
    'error': error,
    'error_type': errorType,
  };
}
