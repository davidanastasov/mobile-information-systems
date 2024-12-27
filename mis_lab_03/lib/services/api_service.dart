import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mis_lab_03/models/joke_model.dart';

class ApiService{

  static Future<List<String>> getJokeTypesFromAPI() async {
    final response = await http.get(Uri.parse("https://official-joke-api.appspot.com/types"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return List<String>.from(data);
    }
    else{
      throw Exception("Failed to load data!");
    }
  }

  static Future<List<Joke>> getJokesForTypeFromAPI(String type) async {
    final response = await http.get(Uri.parse("https://official-joke-api.appspot.com/jokes/$type/ten"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var jokes = data.map((joke) => Joke.fromJson(joke));
      return List<Joke>.from(jokes);
    }
    else{
      throw Exception("Failed to load data!");
    }
  }

  static Future<Joke> getRandomJokeFromAPI() async {
    final response = await http.get(Uri.parse("https://official-joke-api.appspot.com/random_joke"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Joke.fromJson(data);
    }
    else{
      throw Exception("Failed to load data!");
    }
  }

}