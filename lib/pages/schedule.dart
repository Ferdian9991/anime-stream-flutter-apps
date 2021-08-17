import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:movie_ui/service/api_service.dart';
import 'package:movie_ui/pages/detail_movie_page.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  int _current = 0;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              "Senin",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder(
            future: scheduleAnime(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                snapshot.data
                    .removeWhere((val) => val['day_updated'] != "Senin");
                return Container(
                  height: 170,
                  margin: EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var endpoint = snapshot.data[index]['id'];
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
                                    snapshot.data[index]['episode'].toString(),
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
                                snapshot.data[index]['title'],
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
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    color: Colors.black12,
                    height: 160,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              "Selasa",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder(
            future: scheduleAnime(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                snapshot.data
                    .removeWhere((val) => val['day_updated'] != "Selasa");
                return Container(
                  height: 170,
                  margin: EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var endpoint = snapshot.data[index]['id'];
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
                                    snapshot.data[index]['episode'].toString(),
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
                                snapshot.data[index]['title'],
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
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    color: Colors.black12,
                    height: 160,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              "Rabu",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder(
            future: scheduleAnime(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                snapshot.data
                    .removeWhere((val) => val['day_updated'] != "Rabu");
                return Container(
                  height: 170,
                  margin: EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var endpoint = snapshot.data[index]['id'];
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
                                    snapshot.data[index]['episode'].toString(),
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
                                snapshot.data[index]['title'],
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
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    color: Colors.black12,
                    height: 160,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              "Kamis",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder(
            future: scheduleAnime(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                snapshot.data
                    .removeWhere((val) => val['day_updated'] != "Kamis");
                return Container(
                  height: 170,
                  margin: EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var endpoint = snapshot.data[index]['id'];
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
                                    snapshot.data[index]['episode'].toString(),
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
                                snapshot.data[index]['title'],
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
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    color: Colors.black12,
                    height: 160,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              "Jumat",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder(
            future: scheduleAnime(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                snapshot.data
                    .removeWhere((val) => val['day_updated'] != "Jumat");
                return Container(
                  height: 170,
                  margin: EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var endpoint = snapshot.data[index]['id'];
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
                                    snapshot.data[index]['episode'].toString(),
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
                                snapshot.data[index]['title'],
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
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    color: Colors.black12,
                    height: 160,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              "Sabtu",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder(
            future: scheduleAnime(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                snapshot.data
                    .removeWhere((val) => val['day_updated'] != "Sabtu");
                return Container(
                  height: 170,
                  margin: EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var endpoint = snapshot.data[index]['id'];
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
                                    snapshot.data[index]['episode'].toString(),
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
                                snapshot.data[index]['title'],
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
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    color: Colors.black12,
                    height: 160,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              "Minggu",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder(
            future: scheduleAnime(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                snapshot.data
                    .removeWhere((val) => val['day_updated'] != "Minggu");
                return Container(
                  height: 170,
                  margin: EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var endpoint = snapshot.data[index]['id'];
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
                                    snapshot.data[index]['episode'].toString(),
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
                                snapshot.data[index]['title'],
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
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    color: Colors.black12,
                    height: 160,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
            },
          ),
          // Continue
        ],
      ),
    );
  }
}
