import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storesight/infrastructure/exceptions.dart';
import 'package:storesight/infrastructure/utils.dart';
import 'package:storesight/models/product_model.dart';
import 'package:storesight/services/product_service.dart';
import 'package:storesight/view_models/home_cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  static HomeCubit get(context) => BlocProvider.of(context);
  final ProductService _productService = ProductService();
  List<StoreModel> products = [];
  Future<void> getProducts() async {
    emit(GetProductsLoadingState());
    await _productService.getProducts().then((value) {
      products = value;
      emit(GetProductsSuccessState());
    }).catchError((error) {
      printLn(error.toString());
      if (error is ApiException) {
        emit(GetProductsErrorState(error: error.errorMessage.toString()));
      }
    });
  }
}
