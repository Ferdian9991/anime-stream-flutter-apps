import 'dart:convert';
import 'dart:js';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

final String url = "https://anime.rifkiystark.tech/api/ongoing/page/1";

Future getNime() async {
  var response = await http.get(Uri.parse(url));
  var value = json.decode(response.body);
  return value['animeList'];
}

final String completed = "https://anime.rifkiystark.tech/api/complete";

Future fantasyGenre() async {
  var response = await http.get(Uri.parse(completed));
  var value = json.decode(response.body);
  return value['animeList'];
}

final String action = "https://anime.rifkiystark.tech/api/genres/action/page/1";

Future actionGenre() async {
  var response = await http.get(Uri.parse(action));
  var value = json.decode(response.body);
  return value['animeList'];
}

final String genres = "https://anime.rifkiystark.tech/api/genres";

Future genreAnime() async {
  var response = await http.get(Uri.parse(genres));
  var value = json.decode(response.body);
  return value['genreList'];
}
