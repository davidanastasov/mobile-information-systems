import 'package:flutter/material.dart';
import 'package:mis_lab_03/screens/home.dart';
import 'package:mis_lab_03/screens/jokes.dart';
import 'package:mis_lab_03/screens/random_joke.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 03',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/jokes': (context) => const Jokes(),
        '/random': (context) => const RandomJoke(),
      },
    );
  }
}
