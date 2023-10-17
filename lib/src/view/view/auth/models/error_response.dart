class ErrorResponse {
  String? detail;
  String? message;
  String? error;
  String? statusCode;

  ErrorResponse({
    this.detail,
    this.message,
    this.error,
    this.statusCode,
  });

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    detail = json['detail']?.toString();
    message = json['message'];
    error = json['error'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['detail'] = detail;
    data['message'] = message;
    data['error'] = error;
    data['statusCode'] = statusCode;
    return data;
  }
}
