import 'package:flutter/material.dart';

class ProductActions extends StatelessWidget {
  const ProductActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: OutlinedButton(
              onPressed: () {}, child: const Text('Add to Cart'))),
      const SizedBox(width: 10),
      Expanded(
          child: FilledButton(onPressed: () {}, child: const Text('Buy Now')))
    ]);
  }
}
