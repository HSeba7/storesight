import 'dart:convert';

import 'package:storesight/infrastructure/http_service.dart';
import 'package:storesight/models/product_model.dart';

class ProductService {
  final HttpService _httpService = HttpService();
  Future<List<StoreModel>> getProducts() async {
    List<StoreModel> products = [];
    await _httpService
        .doGetExt("https://storesight.pl/wp-json/wc/v3/products")
        .then((value) {
      final decodedData = jsonDecode(value.toString());
      for (var breedList in decodedData) {
        products.add(StoreModel.fromJson(breedList));
      }
    });
    return products;
  }
}
