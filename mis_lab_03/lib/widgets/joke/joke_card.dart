import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mis_lab_03/models/joke_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JokeCard extends StatefulWidget {
  final Joke joke;

  const JokeCard({super.key, required this.joke});

  @override
  State<JokeCard> createState() => _JokeCardState();
}

class _JokeCardState extends State<JokeCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween(end: 1.0, begin: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _status = status;
      });

    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteJokes = prefs.getStringList('favorite_jokes') ?? [];
    setState(() {
      isFavorite = favoriteJokes.contains(jsonEncode(widget.joke.toJson()));
    });
  }

  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteJokes = prefs.getStringList('favorite_jokes') ?? [];

    setState(() {
      final jokeJson = jsonEncode(widget.joke.toJson());
      if (isFavorite) {
        favoriteJokes.remove(jokeJson);
      } else {
        favoriteJokes.add(jokeJson);
      }
      isFavorite = !isFavorite;
    });

    await prefs.setStringList('favorite_jokes', favoriteJokes);
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0015)
          ..rotateY(pi * _animation.value),
        child: InkWell(
            onTap: () {
              if (_status == AnimationStatus.dismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
            child: Card(
                child: _animation.value <= 0.5
                    ? Container(
                        color: Colors.blue,
                        width: 240,
                        height: 300,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          widget.joke.setup,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                          ),
                        ))
                    : Transform(
                        alignment: FractionalOffset.center,
                        transform: Matrix4.identity()..rotateY(pi),
                        child: Stack(children: [
                          Container(
                              color: Colors.redAccent,
                              padding: const EdgeInsets.all(20),
                              child: Center(
                                  child: Text(
                                widget.joke.punchline,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                ),
                              ))),
                          Positioned(
                              bottom: 15,
                              right: 15,
                              child: InkWell(
                                onTap: () {
                                  _toggleFavorite();
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.favorite,
                                    color: isFavorite
                                        ? Colors.redAccent
                                        : Colors.grey,
                                  ),
                                ),
                              ))
                        ])))));
  }
}
