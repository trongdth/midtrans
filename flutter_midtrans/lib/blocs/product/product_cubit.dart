import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_midtrans/blocs/product/product_state.dart';
import 'package:flutter_midtrans/data/models/product.dart';
import 'package:flutter_midtrans/repositories/product_repo.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepo;

  ProductCubit(this.productRepo) : super(ProductInitial());

  Future<void> loadProducts() async {
    emit(ProductLoading());
    var products = await productRepo.loadProducts();
    emit(ProductLoadedSuccess(products: products.products));
  }

  Future<void> purchase(Product product) async {
    emit(ProductLoading());
    var response = await productRepo.buyProduct(product: product);
    emit(ProductCreateOrderSuccess(transactionToken: response.data));
  }
}
