import 'package:dio/dio.dart';
import 'package:flutter_midtrans/helpers/error_codes.dart';

Future<APIResponse> handleResponse(Future<Response> request) async {
  try {
    Response response = await request;
    if (response == null) return APIResponse(success: false);

    var data = response.data;
    var success = data != null && data["status"] == 1;
    return APIResponse(success: success, data: data);
  } on DioError catch (error) {
    throw error;
  }
}

class APIResponse {
  final bool success;
  final dynamic data;

  APIResponse({this.success = false, this.data});
}

class APIUnauthorizedException implements Exception {
  String message;
  APIUnauthorizedException(this.message);
}

class APIUnknownError implements Exception {
  String message;
  APIUnknownError(this.message);

  @override
  String toString() {
    return message;
  }
}

class APIErrorWithCode implements Exception {
  final String defaultMessage;
  final num errorCode;

  APIErrorWithCode(this.errorCode, {this.defaultMessage});

  get message {
    var msg = ErrorCodes.errorCodes[errorCode];
    if (msg == null) return defaultMessage ?? "Unknown error code: $errorCode";
    return msg;
  }

  @override
  String toString() {
    return message;
  }
}
