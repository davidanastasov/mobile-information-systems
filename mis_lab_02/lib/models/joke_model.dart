class Joke {
  String type;
  String setup;
  String punchline;
  int id;

  Joke(
      {required this.type,
      required this.setup,
      required this.punchline,
      required this.id});

  Joke.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        setup = json['setup'],
        punchline = json['punchline'],
        id = json['id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = this.type;
    data['setup'] = this.setup;
    data['punchline'] = this.punchline;
    data['id'] = this.id;
    return data;
  }
}
