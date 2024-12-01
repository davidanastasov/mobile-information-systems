import 'package:flutter/material.dart';

class ProductInformation extends StatelessWidget {
  final String title;
  final double? price;
  final String? description;

  const ProductInformation(
      {super.key, required this.title, this.price, this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: const TextStyle(
                  fontSize: 16,
                )),
            Text("\$$price",
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
        if (description != null)
          Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(description!,
                  style: const TextStyle(fontSize: 12))),
      ],
    );
  }
}