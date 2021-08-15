import 'dart:convert';
import 'dart:js';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

final String url = "https://kusonime-scrapper.glitch.me/api/genres/fantasy/1";

Future fantasyGenre() async {
  var response = await http.get(Uri.parse(url));
  var value = json.decode(response.body);
  value.forEach((element) {
    return value;
  });
  return value;
}
