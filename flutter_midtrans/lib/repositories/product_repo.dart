import 'package:flutter/material.dart';
import 'package:flutter_midtrans/helpers/api_response.dart';
import 'package:flutter_midtrans/services/api.dart';
import 'package:flutter_midtrans/services/response.dart';

class ProductRepository {
  final BaseAPI api;

  ProductRepository({
    @required this.api,
  }) : assert(api != null);

  Future<ListProductResponse> loadProducts() async {
    var response = await handleResponse(api.loadProducts());
    if (!response.success) return null;
    return ListProductResponse.fromMap(response.data);
  }
}
