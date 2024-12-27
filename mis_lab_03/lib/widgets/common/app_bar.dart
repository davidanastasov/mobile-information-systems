import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool randomJokeButton;

  const CustomAppBar(
      {super.key, this.title = "JOKES", this.randomJokeButton = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(title),
      centerTitle: true,
      actions: randomJokeButton
          ? [
              IconButton(
                onPressed: () => {Navigator.pushNamed(context, '/random')},
                icon: const Icon(
                  Icons.shuffle,
                  color: Colors.black,
                  size: 24.0,
                  semanticLabel: 'Random joke',
                ),
              )
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
