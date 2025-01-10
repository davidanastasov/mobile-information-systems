import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:mis_lab_03/widgets/common/app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/joke_model.dart';
import '../widgets/joke/joke_card.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<Joke>? jokes;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getFavoriteJokes();
  }

  void getFavoriteJokes() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteJokes = prefs.getStringList('favorite_jokes') ?? [];

    // Deserialize the jokes
    setState(() {
      jokes =
          favoriteJokes.map((joke) => Joke.fromJson(jsonDecode(joke))).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = jokes == null;
    final hasNoFavorites = jokes != null && jokes!.isEmpty;

    return Scaffold(
      appBar: const CustomAppBar(title: "Favorite Jokes"),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasNoFavorites
              ? const Center(
                  child: Text(
                    "You have no favorite jokes yet!",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : Swiper(
                  itemBuilder: (context, index) {
                    final joke = jokes![index];
                    return JokeCard(joke: joke);
                  },
                  itemCount: jokes!.length,
                  itemWidth: 350,
                  itemHeight: 500,
                  layout: SwiperLayout.TINDER,
                  loop: false,
                  pagination: const SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      activeColor: Colors.blue,
                      color: Colors.black12,
                    ),
                  ),
                ),
    );
  }
}
