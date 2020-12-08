import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_midtrans/data/models/product.dart';

class ProductState extends Equatable {
  final List<Object> props;
  const ProductState([this.props]);
}

class ProductInitial extends ProductState {
  @override
  String toString() => 'ProductInitial';
}

class ProductLoading extends ProductState {
  @override
  String toString() => 'ProductLoading';
}

class ProductLoadedSuccess extends ProductState {
  final List<Product> products;
  ProductLoadedSuccess({@required this.products}) : super([products]);

  @override
  String toString() => 'ProductLoadedSuccess';
}

class ProductCreateOrderSuccess extends ProductState {
  final String transactionToken;
  ProductCreateOrderSuccess({@required this.transactionToken}) : super([transactionToken]);

  @override
  String toString() => 'ProductCreateOrderSuccess';
}

class ProductFailure extends ProductState {
  final String error;
  ProductFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'ProductFailure { error: $error }';
}
