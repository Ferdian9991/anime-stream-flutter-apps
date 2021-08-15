import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_ui/base_config.dart';
import 'package:movie_ui/model/movie.dart';
import 'package:movie_ui/service/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:better_player/better_player.dart';

class AnimePlayer extends StatefulWidget {
  final String eps;

  AnimePlayer(this.eps);
  @override
  _AnimePlayerPageState createState() => _AnimePlayerPageState();
}

class _AnimePlayerPageState extends State<AnimePlayer> {
  @override
  Widget build(BuildContext context) {
    final String endpoint = widget.eps;
    final String url = "https://anime.rifkiystark.tech/api/eps/$endpoint";

    Future getAnimeEps() async {
      var response = await http.get(Uri.parse(url));
      var value = json.decode(response.body);
      print(value);
      return value;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        title: Row(
          children: [
            Text(
              "F",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Nime",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.bookmark_border,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: secondaryColor,
      extendBodyBehindAppBar: false,
      body: FutureBuilder(
        future: getAnimeEps(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data['link_stream']);
            return BetterPlayer.network(
              snapshot.data['link_stream'],
              betterPlayerConfiguration:
                  BetterPlayerConfiguration(aspectRatio: 16 / 9),
            );
          } else {
            return Text("hai");
          }
        },
      ),
    );
  }
}
