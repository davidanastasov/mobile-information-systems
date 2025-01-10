import 'package:flutter/material.dart';
import 'package:mis_lab_03/models/joke_model.dart';
import 'package:mis_lab_03/services/api_service.dart';
import 'package:mis_lab_03/widgets/common/app_bar.dart';
import 'package:mis_lab_03/widgets/joke/joke_card.dart';

class RandomJoke extends StatefulWidget {
  const RandomJoke({super.key});

  @override
  State<RandomJoke> createState() => _RandomJokeState();
}

class _RandomJokeState extends State<RandomJoke> {
  Joke? joke;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getRandomJoke();
  }

  void getRandomJoke() async {
    ApiService.getRandomJokeFromAPI().then((response) {
      setState(() {
        joke = response;
      });
    }).catchError((error) {
      print("Error: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = joke == null;

    return Scaffold(
        appBar: const CustomAppBar(title: "Random Joke"),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: SizedBox(
                    width: 320, height: 450, child: JokeCard(joke: joke!))));
  }
}
