import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:mis_lab_03/models/joke_model.dart';
import 'package:mis_lab_03/services/api_service.dart';
import 'package:mis_lab_03/widgets/common/app_bar.dart';
import 'package:mis_lab_03/widgets/joke/joke_card.dart';

class Jokes extends StatefulWidget {
  const Jokes({super.key});

  @override
  State<Jokes> createState() => _JokesState();
}

class _JokesState extends State<Jokes> {
  List<Joke>? jokes;
  String type = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    type = ModalRoute.of(context)?.settings.arguments as String;
    if (type.isNotEmpty) {
      getJokes(type);
    }
  }

  void getJokes(String type) async {
    ApiService.getJokesForTypeFromAPI(type).then((response) {
      setState(() {
        jokes = response;
      });
    }).catchError((error) {
      print("Error: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = jokes?.isEmpty ?? true;
    var upperCaseType = type[0].toUpperCase() + type.substring(1, type.length);

    return Scaffold(
      appBar: CustomAppBar(title: "$upperCaseType Jokes"),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
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
                      activeColor: Colors.blue, color: Colors.black12))),
    );
  }
}
