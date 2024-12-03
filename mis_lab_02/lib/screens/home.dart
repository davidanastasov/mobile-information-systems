import 'package:flutter/material.dart';
import 'package:mis_lab_02/services/api_service.dart';
import 'package:mis_lab_02/widgets/common/app_bar.dart';
import 'package:mis_lab_02/widgets/joke_type/joke_type_grid.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> types = [];

  @override
  void initState() {
    super.initState();
    getProductsFromAPI();
  }

  void getProductsFromAPI() async {
    ApiService.getJokeTypesFromAPI().then((response) {
      setState(() {
        types = response;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = types.isEmpty;

    return Scaffold(
      appBar: const CustomAppBar(title: "Joke Cards", randomJokeButton: true),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : JokeTypeGrid(types: types),
    );
  }
}
