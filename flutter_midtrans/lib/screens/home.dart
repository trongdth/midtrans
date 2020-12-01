import 'package:flutter/material.dart';
import 'package:flutter_midtrans/blocs/product/product_cubit.dart';
import 'package:flutter_midtrans/config/config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductCubit _productCubit;

  @override
  void initState() {
    super.initState();
    _productCubit = context.read<ProductCubit>();
    _productCubit.loadProducts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 30,
        title: Text(
          'WELCOME',
          style: TextStyle(
            color: App.theme.colors.text9,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
