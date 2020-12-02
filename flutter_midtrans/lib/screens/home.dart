import 'package:flutter/material.dart';
import 'package:flutter_midtrans/blocs/product/product_cubit.dart';
import 'package:flutter_midtrans/blocs/product/product_state.dart';
import 'package:flutter_midtrans/config/config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_midtrans/data/models/product.dart';
import 'package:flutter_midtrans/widgets/common/button_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductCubit _productCubit;
  List<Product> _products;

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

  _buildTopItem(Product product) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Align(
            alignment: Alignment.bottomRight,
            child: App.theme.getSvgPicture('top_bg', height: 400),
          ),
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15, right: 45, top: 30),
              child: Image(
                image: AssetImage('assets/${product.productImageName}.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 90),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  product.productName,
                  style: App.theme.styles.title2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 90),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  product.productDesc,
                  style: App.theme.styles.body1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 90, right: 20),
              child: ButtonWidget(
                onPressed: () => _productCubit.purchase(product),
                title: 'BUY NOW',
              ),
            )
          ],
        ),
      ],
    );
  }

  _buildItem(Product product) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 100,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage('assets/${product.productImageName}.png'),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.productName,
                    textAlign: TextAlign.left,
                    style: App.theme.styles.body2,
                  ),
                  Text(
                    product.productDesc,
                    textAlign: TextAlign.left,
                    style: App.theme.styles.body3,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ButtonWidget(
              title: 'Buy Now',
              onPressed: () => _productCubit.purchase(product),
              textStyle: App.theme.styles.body3.copyWith(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: InkWell(
          child: Icon(Icons.sort),
        ),
        title: Text(
          'WELCOME',
          style: TextStyle(
            color: App.theme.colors.text9,
          ),
        ),
      ),
      body: RefreshIndicator(
        child: BlocListener<ProductCubit, ProductState>(
          listener: (context, state) {
            if (state is ProductLoadedSuccess) {
              _products = state.products;
            }
          },
          child: BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
            if (state is ProductLoading) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(App.theme.colors.primary),
                ),
              );
            }
            return ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                var product = _products[index];

                if (index == 0) {
                  return _buildTopItem(product);
                }

                return _buildItem(product);
              },
            );
          }),
        ),
        onRefresh: () async => _productCubit.loadProducts(),
      ),
    );
  }
}
