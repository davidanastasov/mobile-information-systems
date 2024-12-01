import 'package:flutter/material.dart';
import 'package:mis_lab_01/models/product_model.dart';
import 'package:mis_lab_01/services/api_service.dart';
import 'package:mis_lab_01/widgets/common/app_bar.dart';
import 'package:mis_lab_01/widgets/product/product_grid.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    getProductsFromAPI();
  }

  void getProductsFromAPI() async {
    ApiService.getProductsFromAPI().then((x) {
      setState(() {
        products = x;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = products.isEmpty;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ProductGrid(products: products),
    );
  }
}
