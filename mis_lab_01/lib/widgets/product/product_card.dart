import 'package:flutter/material.dart';
import 'package:mis_lab_01/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final int id;
  final String name;
  final String image;
  final double price;

  const ProductCard(
      {super.key,
      required this.id,
      required this.name,
      required this.image,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 250,
      child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: Colors.red[50],
          onTap: () => {
                Navigator.pushNamed(context, '/details',
                    arguments: Product(id: id, title: name, thumbnail: image))
              },
          child: Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Image.network(image, fit: BoxFit.contain,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator());
                })),
                Text(name,
                    style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis)),
                Text("\$$price",
                    style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          )),
    );
  }
}
