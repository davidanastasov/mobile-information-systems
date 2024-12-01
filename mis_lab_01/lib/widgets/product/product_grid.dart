import 'package:flutter/material.dart';
import 'package:mis_lab_01/models/product_model.dart';
import 'package:mis_lab_01/widgets/product/product_card.dart';

class ProductGrid extends StatefulWidget {
  final List<Product> products;
  const ProductGrid({super.key, required this.products});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        padding: const EdgeInsets.all(4),
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        semanticChildCount: 250,
        childAspectRatio: 200 / 244,
        shrinkWrap: true,
        children: widget.products
            .map((product) => ProductCard(
                id: product.id,
                name: product.title,
                image: product.thumbnail,
                price: product.price!))
            .toList());
  }
}