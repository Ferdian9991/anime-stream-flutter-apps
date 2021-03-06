import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:movie_ui/base_config.dart';
import 'package:movie_ui/pages/anime_player.dart';
import 'package:http/http.dart' as http;

class DetailMoviePage extends StatefulWidget {
  final String anime;

  DetailMoviePage(this.anime);
  @override
  _DetailMoviePageState createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  @override
  Widget build(BuildContext context) {
    final String endpoint = widget.anime;
    final String url = "https://anime.rifkiystark.tech/api/anime/$endpoint";

    Future getAnimeDetails() async {
      var response = await http.get(Uri.parse(url));
      var value = json.decode(response.body);
      return value;
    }

    Future actionRand() async {
      var rand = new Random();
      var randValue = rand.nextInt(20);

      final String action =
          "https://anime.rifkiystark.tech/api/genres/action/page/" +
              randValue.toString();
      var response = await http.get(Uri.parse(action));
      var value = json.decode(response.body);
      return value['animeList'];
    }

    getAnimeDetails();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: getAnimeDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var title;
            var thumb;
            var genre;
            var duration;
            var season;
            if (snapshot.hasData) {
              title = snapshot.data['title'];
              thumb = snapshot.data['thumb'];
              genre = snapshot.data['genre_list'];
              duration = snapshot.data['duration'];
              season = snapshot.data['release_date'];
            } else {
              title = "";
              thumb = "";
              genre = "";
              season = "";
              duration = "";
            }
            var score = snapshot.data['score'];
            if (score == null) {
              score = 0;
            }
            var genres = genre.map((item) => item['genre_name']).join(", ");
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          thumb,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            secondaryColor,
                            secondaryColor.withOpacity(0.9),
                            secondaryColor.withOpacity(0.7),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, bottom: 21),
                                child: Container(
                                  height: 150,
                                  width: 130,
                                  margin: EdgeInsets.only(right: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        snapshot.data['thumb'],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 16 * 9,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5, bottom: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: TextStyle(
                                      color: black.withOpacity(0.7),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    season,
                                    style: TextStyle(
                                      color: black.withOpacity(0.7),
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "Status: " + snapshot.data['status'],
                                    style: TextStyle(
                                      color: black.withOpacity(0.7),
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    duration,
                                    style: TextStyle(
                                      color: black.withOpacity(0.7),
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "Genre: " + genres,
                                    style: TextStyle(
                                      color: black.withOpacity(0.7),
                                      fontSize: 15,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                  ),
                                  SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Text(
                                        snapshot.data['score'].toString(),
                                        style: TextStyle(
                                          color: Colors.yellow[900],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      ...List.generate(
                                        5,
                                        (index) => Icon(
                                          Icons.star,
                                          color: (index < (score / 2).floor())
                                              ? Colors.yellow[700]
                                              : Colors.black87,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: getAnimeDetails(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var sinopsis = snapshot.data['synopsis'];
                        var thumb = snapshot.data['thumb'];
                        var rate = snapshot.data['score'];
                        var status = snapshot.data['status'];
                        var studio = snapshot.data['studio'];
                        return Container(
                          height: 41,
                          margin: EdgeInsets.only(
                            top: 2,
                            bottom: 15,
                            right: 15,
                            left: 15,
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data['episode_list'].length,
                            itemBuilder: (context, index) {
                              // var length = snapshot.data[index]['id'].length;
                              // var endpoint = snapshot.data[index]['id']
                              //     .substring(0, length - 1);
                              var episodeList = snapshot.data['episode_list'];
                              var checker = episodeList[index]['title']
                                  .contains("Episode");
                              if (checker == true) {
                                var epsTitle =
                                    episodeList[index]['title'].substring(
                                  episodeList[index]['title']
                                      .indexOf("Episode"),
                                  episodeList[index]['title']
                                      .indexOf("Subtitle"),
                                );
                                return GestureDetector(
                                  onTap: () {
                                    final String endpoint = snapshot
                                        .data['episode_list'][index]['id'];
                                    final String url =
                                        "https://anime.rifkiystark.tech/api/eps/$endpoint";

                                    Future getAnimeEps() async {
                                      var response =
                                          await http.get(Uri.parse(url));
                                      var value = json.decode(response.body);
                                      return value;
                                    }

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return FutureBuilder(
                                            future: getAnimeEps(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return AnimePlayer(
                                                  name: snapshot.data['title'],
                                                  eps: snapshot
                                                      .data['link_stream'],
                                                  synopsis: sinopsis,
                                                  thumbnail: thumb,
                                                  genreList: genres,
                                                  score: rate.toString(),
                                                  status: status,
                                                  studio: studio,
                                                  list: episodeList,
                                                );
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(right: 7),
                                    decoration: BoxDecoration(
                                        color: Colors.red[600],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: Text(
                                      epsTitle,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return GestureDetector(
                                  onTap: () {
                                    final String endpoint = snapshot
                                        .data['episode_list'][index]['id'];
                                    final String url =
                                        "https://anime.rifkiystark.tech/api/eps/$endpoint";

                                    Future getAnimeEps() async {
                                      var response =
                                          await http.get(Uri.parse(url));
                                      var value = json.decode(response.body);
                                      return value;
                                    }

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return FutureBuilder(
                                            future: getAnimeEps(),
                                            builder: (context, snapshot) {
                                              final String name = "";
                                              final String link = "";
                                              final String synopsis = "";

                                              if (snapshot.hasData) {
                                                return AnimePlayer(
                                                  name: snapshot.data['title'],
                                                  eps: snapshot
                                                      .data['link_stream'],
                                                  synopsis: sinopsis,
                                                );
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(right: 7),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: Text(
                                      episodeList[index]['title'],
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      } else {
                        return Container(
                          height: 41,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Sinopsis",
                      style: TextStyle(
                        color: black,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 10,
                      right: 15,
                    ),
                    child: Text(
                      snapshot.data['synopsis'],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 10,
                    ),
                    child: Text(
                      "Tonton Juga",
                      style: TextStyle(
                        color: black,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: actionRand(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          height: 170,
                          margin: EdgeInsets.only(
                            top: 10,
                            left: 15,
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              var length = snapshot.data[index]['id'].length;
                              var endpoint = snapshot.data[index]['id']
                                  .substring(28, length);
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailMoviePage(
                                        endpoint,
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: <Widget>[
                                        Container(
                                          height: 140,
                                          width: 110,
                                          margin: EdgeInsets.only(right: 15),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                snapshot.data[index]['thumb'],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Colors.red[600],
                                              borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(20),
                                                topLeft: Radius.circular(15),
                                              )),
                                          child: Text(
                                            snapshot.data[index]['score']
                                                .toString(),
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
                                    Container(
                                      width: 110,
                                      child: Text(
                                        snapshot.data[index]['anime_name'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Container(
                          height: 160,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
