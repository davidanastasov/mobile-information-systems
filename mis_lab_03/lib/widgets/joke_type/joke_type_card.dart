import 'package:flutter/material.dart';

class JokeTypeCard extends StatelessWidget {
  final String type;

  const JokeTypeCard({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    var upperCaseType = type[0].toUpperCase() + type.substring(1, type.length);

    return Container(
      color: Colors.white,
      height: 250,
      child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: Colors.red[50],
          onTap: () =>
              {Navigator.pushNamed(context, '/jokes', arguments: type)},
          child: Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(upperCaseType,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis)),
              ],
            ),
          )),
    );
  }
}
