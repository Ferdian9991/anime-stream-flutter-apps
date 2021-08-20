import 'package:flutter/material.dart';
import 'package:movie_ui/base_config.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:video_player/video_player.dart';

class AnimePlayer extends StatefulWidget {
  final String eps;
  final String name;
  final String synopsis;
  final String thumbnail;
  final String genreList;
  final String score;
  final String studio;
  final String status;

  AnimePlayer({
    this.eps,
    this.name,
    this.synopsis,
    this.thumbnail,
    this.genreList,
    this.score,
    this.status,
    this.studio,
  });
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
        color: Colors.black12,
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
                        height: 185,
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            fit: BoxFit.fill,
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
                        padding: const EdgeInsets.only(top: 15),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 16 * 9,
                          child: Text(
                            widget.name,
                            style: TextStyle(
                              color: black.withOpacity(0.7),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width / 16 * 9,
                        child: Text(
                          "Studio: " + widget.studio,
                          style: TextStyle(
                            color: black.withOpacity(0.7),
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        width: MediaQuery.of(context).size.width / 16 * 9,
                        child: Text(
                          "Genre: " + widget.genreList,
                          style: TextStyle(
                            color: black.withOpacity(0.7),
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
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
                        width: MediaQuery.of(context).size.width / 16 * 9,
                        child: Text(
                          "Status: " + widget.status,
                          style: TextStyle(
                            color: black.withOpacity(0.7),
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                widget.synopsis,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
