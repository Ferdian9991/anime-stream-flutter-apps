import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_ui/base_config.dart';
import 'package:movie_ui/model/animeByGenre.dart';
import 'package:movie_ui/pages/detail_movie_page.dart';
import 'package:http/http.dart' as http;

class DetailGenre extends StatefulWidget {
  final String genre;

  DetailGenre(this.genre);
  @override
  _DetailGenrePageState createState() => _DetailGenrePageState();
}

class _DetailGenrePageState extends State<DetailGenre> {
  ScrollController scrollController = ScrollController();
  int currentPage = 2;
  int page = 1;
  @override
  void initState() {
    super.initState();
    animeByGenre();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        animeByGenre();
        setState(() {
          page = currentPage++;
        });
      } else {
        setState(() {
          page = currentPage;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  List<AnimeByGenre> _nime = [];
  Future<Null> animeByGenre() async {
    final String endpoints = widget.genre;
    final String urL =
        "https://anime.rifkiystark.tech/api/genres/$endpoints/page/" +
            page.toString();
    final response = await http.get(Uri.parse(urL));
    if (response.statusCode == 200) {
      setState(() {
        final data = json.decode(response.body);
        for (Map i in data['animeList']) {
          _nime.add(AnimeByGenre.fromJson(i));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var length = widget.genre.toUpperCase().length;
    var capitalize = widget.genre.toUpperCase().substring(0, 1);
    var titleLower = widget.genre.substring(1, length);
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    var counter;
    if (shortestSide < 600) {
      counter = 3;
    } else {
      counter = 4;
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
              capitalize,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              titleLower,
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
      body: Padding(
        padding: const EdgeInsets.only(right: 5, left: 5),
        child: GridView.builder(
            controller: scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 8,
              crossAxisCount: counter,
            ),
            padding: EdgeInsets.only(top: 16, left: 15, right: 15),
            itemCount: _nime.length,
            itemBuilder: (context, index) {
              var length = _nime[index].id.length;
              var endpoint = _nime[index].id.substring(28, length);
              return Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                child: Stack(
                  children: <Widget>[
                    Hero(
                        tag: "List",
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailMoviePage(endpoint),
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
                                    _nime[index].name,
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
                                _nime[index].thumb,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.red[600],
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(15),
                          )),
                      child: Text(
                        _nime[index].score.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
