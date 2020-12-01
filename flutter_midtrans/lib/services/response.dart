class BaseResponse {
  String message;
  Map<String, dynamic> data;
  String error;
  BaseResponse(Map<String, dynamic> map) {
    if (map != null) {
      message = map['message'] != null ? map['message'] as String : null;
      data = map['data'];
      error = map['error'] != null ? map['error'] as String : null;
    }
  }
}
