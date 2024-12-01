
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mis_lab_01/models/product_model.dart';

class ApiService{

  static Future<List<Product>> getProductsFromAPI() async {
    var shirtsResponse = await http.get(Uri.parse("https://dummyjson.com/products/category/mens-shirts"));
    var dressesResponse = await http.get(Uri.parse("https://dummyjson.com/products/category/womens-dresses"));

    if (shirtsResponse.statusCode == 200 && dressesResponse.statusCode == 200) {
      var shirts = jsonDecode(shirtsResponse.body)["products"];
      var dresses = jsonDecode(dressesResponse.body)["products"];

      // TODO: Join the arrays and return
      final List<Product> products = [
        ...shirts.map((shirt) => Product.fromJson(shirt)),
        ...dresses.map((dress) => Product.fromJson(dress)),
      ];

      return products;
    } else {
      throw Exception("Failed to load data!");
    }
  }

  static Future<dynamic> getProductDetailsFromAPI(String id) async{
    final response = await http.get(Uri.parse("https://dummyjson.com/products/$id"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    }
    else{
      throw Exception("Failed to load data!");
    }
  }

}