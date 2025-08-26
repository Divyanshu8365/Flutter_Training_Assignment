import 'package:flutter/material.dart';
import 'package:my_app/core/exceptions.dart';
import '../core/api_client.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  final ApiClient _apiClient = ApiClient();

  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _apiClient.fetchProducts();
    } on ApiException catch (_) {
      _products = [];
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
