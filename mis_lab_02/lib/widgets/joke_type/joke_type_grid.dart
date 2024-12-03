import 'package:flutter/material.dart';
import 'package:mis_lab_02/widgets/joke_type/joke_type_card.dart';

class JokeTypeGrid extends StatefulWidget {
  final List<String> types;

  const JokeTypeGrid({super.key, required this.types});

  @override
  State<JokeTypeGrid> createState() => _JokeTypeGridState();
}

class _JokeTypeGridState extends State<JokeTypeGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        padding: const EdgeInsets.all(4),
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        semanticChildCount: 250,
        childAspectRatio: 200 / 200,
        shrinkWrap: true,
        children:
            widget.types.map((type) => JokeTypeCard(type: type)).toList());
  }
}
