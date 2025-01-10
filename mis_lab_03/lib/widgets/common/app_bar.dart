import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showActionButtons;

  const CustomAppBar(
      {super.key, this.title = "JOKES", this.showActionButtons = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(title),
      centerTitle: true,
      actions: showActionButtons
          ? [
              IconButton(
                onPressed: () => {Navigator.pushNamed(context, '/favorite')},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                  size: 24.0,
                  semanticLabel: 'Favorite jokes',
                ),
              ),
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
