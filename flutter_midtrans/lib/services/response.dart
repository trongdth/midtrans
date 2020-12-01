import 'package:flutter_midtrans/data/models/product.dart';

class BaseResponse {
  dynamic data;
  String message;
  BaseResponse(Map<String, dynamic> map) {
    if (map != null) {
      message = map['message'] != null ? map['message'] as String : null;
      data = map['data'];
    }
  }
}

class ListProductResponse extends BaseResponse {
  List<Product> _products;

  List<Product> get products {
    return _products ?? (data as List).map((product) => Product.fromMap(product)).toList();
  }

  ListProductResponse.fromMap(Map<String, dynamic> map) : super(map);
}
