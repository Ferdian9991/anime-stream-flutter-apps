import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_ui/base_config.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:video_player/video_player.dart';
import 'package:movie_ui/pages/detail_movie_page.dart';

class AnimePlayer extends StatefulWidget {
  final String eps;
  final String name;
  final String synopsis;
  final String thumbnail;
  final String genreList;
  final String score;
  final String studio;
  final String status;
  var list = [];

  AnimePlayer(
      {this.eps,
      this.name,
      this.synopsis,
      this.thumbnail,
      this.genreList,
      this.score,
      this.status,
      this.studio,
      this.list});
  @override
  _AnimePlayerPageState createState() => _AnimePlayerPageState();
}

class _AnimePlayerPageState extends State<AnimePlayer> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(widget.eps);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,

      //  Try playing around with some of these other options:
      // showControls: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red[500],
        handleColor: Colors.red[700],
        backgroundColor: Colors.grey,
        bufferedColor: Colors.white,
      ),
      placeholder: Container(
        color: Colors.black,
      ),
      autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        title: Row(
          children: [
            Text(
              "Wibu",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Desu",
              style: TextStyle(
                color: Colors.red,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width / 16 * 9,
              child: Chewie(controller: _chewieController),
            ),
            Container(
              child: Container(
                color: Colors.grey[100],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          bottom: 21,
                          top: 15,
                        ),
                        child: Container(
                          width: 110,
                          height: 135,
                          margin: EdgeInsets.only(right: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                widget.thumbnail,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            right: 15,
                            left: 14,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 16 * 9,
                            child: Text(
                              widget.name,
                              style: TextStyle(
                                color: black.withOpacity(0.7),
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          padding: EdgeInsets.only(right: 15),
                          width: MediaQuery.of(context).size.width / 16 * 9,
                          child: Text(
                            "Studio: " + widget.studio,
                            style: TextStyle(
                              color: black.withOpacity(0.7),
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          padding: EdgeInsets.only(right: 15),
                          width: MediaQuery.of(context).size.width / 16 * 9,
                          child: Text(
                            "Genre: " + widget.genreList,
                            style: TextStyle(
                              color: black.withOpacity(0.7),
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          padding: EdgeInsets.only(right: 15),
                          width: MediaQuery.of(context).size.width / 16 * 9,
                          child: Text(
                            "Skor: " + widget.score,
                            style: TextStyle(
                              color: black.withOpacity(0.7),
                              fontSize: 17,
                            ),
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          padding: EdgeInsets.only(right: 15),
                          width: MediaQuery.of(context).size.width / 16 * 9,
                          child: Text(
                            "Status: " + widget.status,
                            style: TextStyle(
                              color: black.withOpacity(0.7),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 20,
              ),
              child: Text(
                "Sinopsis:",
                style: TextStyle(
                  color: black,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                widget.synopsis,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 5,
              ),
              child: Text(
                "Tonton Juga :",
                style: TextStyle(
                  color: black,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: 20,
              ),
              child: FutureBuilder(
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
                          var endpoint =
                              snapshot.data[index]['id'].substring(28, length);
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 140,
                                      width: 110,
                                      margin: EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
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
                                            bottomRight: Radius.circular(20),
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
            ),
          ],
        ),
      ),
    );
  }
}
