import 'package:dio/dio.dart';
import 'package:flutter_midtrans/helpers/error_codes.dart';

Future<APIResponse> handleResponse(Future<Response> request) async {
  try {
    Response response = await request;
    if (response == null) return APIResponse(success: false);

    var data = response.data;
    if (response.headers.value('content-type') == 'text/csv') {
      return APIResponse(success: true, data: data);
    }
    var success = data != null && data["status"] == "SUCCESS";
    return APIResponse(success: success, data: data);
  } on DioError catch (error) {
    if (error is DioError) {
      var errorCode;
      if (error?.error != null && error.error is APIErrorWithCode) {
        errorCode = error.error.errorCode;
      } else if (error.response != null && error.response.data != null && error.response?.data is Map) {
        errorCode = error.response?.data["errorCode"];
      } else {
        throw error;
      }

      var serverMessage;
      if (error.response?.data != null) {
        serverMessage = error.response.data["displayMessage"] ?? error.message;
      }

      if (errorCode == null) throw APIUnknownError(serverMessage);
      throw APIErrorWithCode(errorCode, defaultMessage: serverMessage);
    }

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
