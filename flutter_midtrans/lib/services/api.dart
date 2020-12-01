import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_midtrans/config/config.dart';
import 'package:flutter_midtrans/helpers/api_response.dart';
import 'package:flutter_midtrans/helpers/error_codes.dart';
import 'package:flutter_midtrans/helpers/logger/tokoin_log.dart';

abstract class BaseAPI {
  Dio _dio;
  List<Function> _onErrorCallbacks = [];

  _logging() {
    return InterceptorsWrapper(onRequest: (RequestOptions options) async {
      log.i("DIO - REQUEST: [${options.method}] ${options.path}} \n"
          "body:${options?.data} \n"
          "query:${options.queryParameters}");

      return options;
    }, onResponse: (Response response) async {
      log.i("DIO - RESPONSE: [${response.request.method}] ${response.request.path} "
          "${response?.statusCode} [OK]\n"
          "body:${response.request?.data}\n"
          "response:${response?.data}");
      return response;
    }, onError: (DioError e) async {
      log.e("DIO - ERROR: ${e.request.path}\ndata: ${e.request?.data}\nresponse:${e.response?.data}");
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        notifyErrorCallbacks(APIUnauthorizedException('unauthorized'));
      } else {
        notifyErrorCallbacks(e);
      }
      return e;
    });
  }

  void addErrorInterceptor(callback) {
    _onErrorCallbacks.add(callback);
  }

  void notifyErrorCallbacks(Exception error) {
    _onErrorCallbacks.forEach((callback) {
      callback(error);
      if (error is DioError) {
        if (error.response?.statusCode == HttpStatus.badRequest ||
            error.response?.statusCode == HttpStatus.internalServerError) {
          var data = error.response?.data;
          int errorCode = -1;
          try {
            errorCode = data['errorCode'];
          } catch (e) {
            log.i(e.toString());
          }
          if (ErrorCodes.errorCodes.containsKey(errorCode)) throw APIErrorWithCode(errorCode);
          throw APIErrorWithCode(-1);
        }
      }
    });
  }
}

class _ContentType {
  static const JSON = 'application/json';
  static const FORM_URL_ENCODED = 'application/x-www-form-urlencoded';
  static const FORM_DATA = 'multipart/form-data';
}

class API extends BaseAPI {
  static final API _singleton = new API._internal();

  factory API() {
    return _singleton;
  }

  API._internal() {
    _dio = Dio();
    _dio.options.baseUrl = Config.baseURL;
    _dio.options.connectTimeout = 10000; //10s
    _dio.options.receiveTimeout = 8000; //8s
    _dio.options.responseType = ResponseType.json;

    _dio.interceptors.add(_logging());
  }

  _addContentTypeHeader({contentType: _ContentType.JSON}) {
    switch (contentType) {
      case (_ContentType.JSON):
        _dio.options.headers['Content-Type'] = _ContentType.JSON;
        return;
      case (_ContentType.FORM_URL_ENCODED):
        _dio.options.headers['Content-Type'] = _ContentType.FORM_URL_ENCODED;
        return;
      case (_ContentType.FORM_DATA):
        if (_dio.options.headers.containsKey('Content-Type')) _dio.options.headers.remove('Content-Type');
        return;
      default:
        return;
    }
  }
}

final api = new API();
