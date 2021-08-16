import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_ui/base_config.dart';
import 'package:movie_ui/model/movie.dart';
import 'package:movie_ui/service/api_service.dart';
import 'package:movie_ui/pages/anime_player.dart';
import 'package:http/http.dart' as http;

class DetailMoviePage extends StatefulWidget {
  final String movie;

  DetailMoviePage(this.movie);
  @override
  _DetailMoviePageState createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  @override
  Widget build(BuildContext context) {
    final String endpoint = widget.movie;
    final String url = "https://anime.rifkiystark.tech/api/anime/$endpoint";

    Future getAnimeDetails() async {
      var response = await http.get(Uri.parse(url));
      var value = json.decode(response.body);
      return value;
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
            // var genre = snapshot.data['genre_list'];
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
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                color: black.withOpacity(0.7),
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              season,
                              style: TextStyle(
                                color: black.withOpacity(0.7),
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              duration,
                              style: TextStyle(
                                color: black.withOpacity(0.7),
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Genre: " + genres,
                              style: TextStyle(
                                color: black.withOpacity(0.7),
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  snapshot.data['score'].toString(),
                                  style: TextStyle(
                                    color: Colors.yellow[900],
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(width: 5),
                                ...List.generate(
                                  5,
                                  (index) => Icon(
                                    Icons.star,
                                    color: (index <
                                            (snapshot.data['score'] / 2)
                                                .floor())
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
                  ),
                  FutureBuilder(
                    future: getAnimeDetails(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
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
                                                  snapshot.data['link_stream']);
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
                                    episodeList[index]['title'].substring(
                                        episodeList[index]['title']
                                            .indexOf("Episode"),
                                        episodeList[index]['title']
                                            .indexOf("Subtitle")),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
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
                  // FutureBuilder(
                  //   future: getNime(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       return
                  //           // Padding(
                  //           //   padding: const EdgeInsets.only(left: 15, top: 15),
                  //           //   child: Text(
                  //           //     "Cast",
                  //           //     style: TextStyle(
                  //           //       color: white.withOpacity(0.7),
                  //           //       fontSize: 22,
                  //           //       fontWeight: FontWeight.bold,
                  //           //     ),
                  //           //   ),
                  //           // );
                  //           FutureBuilder(
                  //         future: getNime(),
                  //         builder: (context, snapshot) {
                  //           if (snapshot.hasData) {
                  //             var length = snapshot.data.length;
                  //             return Container(
                  //               height: 180,
                  //               margin: EdgeInsets.only(
                  //                 top: 10,
                  //                 left: 16,
                  //               ),
                  //               child: ListView.builder(
                  //                 scrollDirection: Axis.horizontal,
                  //                 itemCount: length,
                  //                 itemBuilder: (context, index) {
                  //                   var link = snapshot.data[index]['link'];
                  //                   return GestureDetector(
                  //                     onTap: () {
                  //                       Navigator.push(
                  //                         context,
                  //                         MaterialPageRoute(
                  //                           builder: (context) =>
                  //                               DetailMoviePage(
                  //                             link['endpoint'],
                  //                           ),
                  //                         ),
                  //                       );
                  //                     },
                  //                     child: Column(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.spaceEvenly,
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                       children: [
                  //                         Container(
                  //                           height: 140,
                  //                           width: 140,
                  //                           margin: EdgeInsets.only(right: 15),
                  //                           decoration: BoxDecoration(
                  //                             borderRadius:
                  //                                 BorderRadius.circular(15),
                  //                             image: DecorationImage(
                  //                               fit: BoxFit.fill,
                  //                               image: NetworkImage(
                  //                                 link['thumbnail'],
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         Container(
                  //                           width: 110,
                  //                           child: Text(
                  //                             snapshot.data[index]['title'],
                  //                             style: TextStyle(
                  //                               color: black,
                  //                               fontSize: 17,
                  //                             ),
                  //                             maxLines: 1,
                  //                             overflow: TextOverflow.clip,
                  //                           ),
                  //                         )
                  //                       ],
                  //                     ),
                  //                   );
                  //                 },
                  //               ),
                  //             );
                  //           } else {
                  //             return Text("error");
                  //           }
                  //         },
                  //       );
                  //     } else {
                  //       return Text("error");
                  //     }
                  //   },
                  // )
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
