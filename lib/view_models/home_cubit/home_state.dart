class HomeState {}

class GetProductsLoadingState extends HomeState {}

class GetProductsSuccessState extends HomeState {}

class GetProductsErrorState extends HomeState {
  String error;
  GetProductsErrorState({required this.error});
}

class GetProductsEmptyState extends HomeState {}
