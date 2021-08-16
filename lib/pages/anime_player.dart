import 'package:flutter/material.dart';
import 'package:movie_ui/base_config.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:video_player/video_player.dart';

class AnimePlayer extends StatefulWidget {
  final String eps;

  AnimePlayer(this.eps);
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

      /* Try playing around with some of these other options:
       showControls: false,
       materialProgressColors: ChewieProgressColors(
         playedColor: Colors.red,
         handleColor: Colors.blue,
         backgroundColor: Colors.grey,
         bufferedColor: Colors.lightGreen,
       ),
       placeholder: Container(
         color: Colors.grey,
       ),
       autoInitialize: true,*/
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
        body: Column(
          children: <Widget>[
            Container(
              height: 280,
              child: Chewie(controller: _chewieController),
            ),
          ],
        )
        // FutureBuilder(
        //   future: getAnimeEps(),
        //   builder: (context, snapshot) {

        //     if (snapshot.hasData) {
        //       print(snapshot.data['link_stream']);
        //       return BetterPlayer.network(
        //         snapshot.data['link_stream'],
        //         betterPlayerConfiguration:
        //             BetterPlayerConfiguration(aspectRatio: 16 / 9),
        //       );
        //     } else {
        //       return Text("hai");
        //     }
        //   },
        // ),
        );
  }
}
