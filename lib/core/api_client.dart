import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/core/constants.dart';
import 'package:my_app/models/product_model.dart';
import 'exceptions.dart';

class ApiClient {
  Future<void> login(String email, String password) async {
    final url = Uri.parse(ApiConstants.loginEndpoint);

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else if (response.statusCode == 401) {
      throw ApiException(
          statusCode: 401, message: "Unauthorized: Invalid Credentials");
    } else if (response.statusCode == 403) {
      throw ApiException(
          statusCode: 403, message: "Forbidden: You don't have permissions");
    } else if (response.statusCode == 400) {
      throw ApiException(
          statusCode: 400, message: "Bad request: Invalid input");
    } else {
      throw ApiException(
          statusCode: response.statusCode,
          message: "Login failed: Try again later.");
    }
  }

  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse(ApiConstants.productsApi);
    final response = await http.get(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      List productsJson = data['products'];
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw ApiException(
          statusCode: 401, message: "Unauthorized: Invalid Credentials");
    } else if (response.statusCode == 403) {
      throw ApiException(
          statusCode: 403, message: "Forbidden: You don't have permissions");
    } else if (response.statusCode == 400) {
      throw ApiException(
          statusCode: 400, message: "Bad request: Invalid query or params");
    } else {
      throw ApiException(
          statusCode: response.statusCode,
          message: "Unexpected error occurred.");
    }
  }
}
