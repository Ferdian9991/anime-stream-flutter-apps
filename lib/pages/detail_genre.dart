import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_ui/base_config.dart';
import 'package:movie_ui/model/movie.dart';
import 'package:movie_ui/service/api_service.dart';
import 'package:movie_ui/pages/detail_movie_page.dart';
import 'package:http/http.dart' as http;

class DetailGenre extends StatefulWidget {
  final String genre;

  DetailGenre(this.genre);
  @override
  _DetailGenrePageState createState() => _DetailGenrePageState();
}

class _DetailGenrePageState extends State<DetailGenre> {
  @override
  Widget build(BuildContext context) {
    final String endpoint = widget.genre;
    final String url =
        "https://anime.rifkiystark.tech/api/genres/$endpoint/page/1";

    Future getAnimeGenre() async {
      var response = await http.get(Uri.parse(url));
      var value = json.decode(response.body);
      return value['animeList'];
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
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
                color: primaryColor,
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
        future: getAnimeGenre(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final double shortestSide =
                MediaQuery.of(context).size.shortestSide;
            var counter;
            if (shortestSide < 600) {
              counter = 2;
            } else {
              counter = 4;
            }
            return Padding(
              padding: const EdgeInsets.only(right: 5, left: 5),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 8,
                    crossAxisCount: counter,
                  ),
                  padding: EdgeInsets.only(top: 16, left: 15, right: 15),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var length = snapshot.data[index]['id'].length;
                    var endpoint =
                        snapshot.data[index]['id'].substring(28, length);
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 5,
                        right: 5,
                      ),
                      child: Hero(
                          tag: snapshot.data[index]['anime_name'],
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailMoviePage(endpoint),
                                ),
                              );
                            },
                            child: GridTile(
                              footer: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                child: Container(
                                  color: Colors.black54,
                                  child: ListTile(
                                    title: Text(
                                      snapshot.data[index]['anime_name'],
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                child: Image.network(
                                  snapshot.data[index]['thumb'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )),
                    );
                  }),
            );
          }
        },
      ),
    );
  }
}
