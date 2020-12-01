import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProductState extends Equatable {
  final List<Object> props;
  const ProductState([this.props]);
}

class ProductInitial extends ProductState {
  @override
  String toString() => 'ProductInitial';
}

class ProductFailure extends ProductState {
  final String error;
  ProductFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'ProductFailure { error: $error }';
}
