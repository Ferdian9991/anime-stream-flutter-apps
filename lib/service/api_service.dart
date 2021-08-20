import 'dart:convert';
import 'package:http/http.dart' as http;

final String url = "https://anime.rifkiystark.tech/api/ongoing/page/1";
final String ongoing2 = "https://anime.rifkiystark.tech/api/ongoing/page/2";

Future getNime() async {
  var response = await http.get(Uri.parse(url));
  var value = json.decode(response.body);
  return value['animeList'];
}

Future scheduleAnime() async {
  var page1 = await http.get(Uri.parse(url));
  var value1 = json.decode(page1.body);
  var page2 = await http.get(Uri.parse(ongoing2));
  var value2 = json.decode(page2.body);
  return value1['animeList'] + value2['animeList'];
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

final String romance =
    "https://anime.rifkiystark.tech/api/genres/romance/page/1";

Future romanceGenre() async {
  var response = await http.get(Uri.parse(romance));
  var value = json.decode(response.body);
  return value['animeList'];
}

final String genres = "https://anime.rifkiystark.tech/api/genres";

Future genreAnime() async {
  var response = await http.get(Uri.parse(genres));
  var value = json.decode(response.body);
  return value['genreList'];
}

final String schedules = "https://anime.rifkiystark.tech/api/schedule";

Future getSchehule() async {
  var response = await http.get(Uri.parse(schedules));
  var value = json.decode(response.body);
  return value['scheduleList'];
}
