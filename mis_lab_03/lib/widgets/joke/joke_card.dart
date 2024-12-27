import 'dart:math';

import 'package:flutter/material.dart';

class JokeCard extends StatefulWidget {
  final String setup;
  final String punchline;

  const JokeCard({super.key, required this.setup, required this.punchline});

  @override
  State<JokeCard> createState() => _JokeCardState();
}

class _JokeCardState extends State<JokeCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

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
                          widget.setup,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                          ),
                        ))
                    : Transform(
                        alignment: FractionalOffset.center,
                        transform: Matrix4.identity()..rotateY(pi),
                        child: Container(
                            color: Colors.redAccent,
                            width: 240,
                            height: 300,
                            padding: const EdgeInsets.all(20),
                            child: Center(
                                child: Text(
                              widget.punchline,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                              ),
                            )))))));
  }
}
