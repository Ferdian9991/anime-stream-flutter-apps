import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_ui/base_config.dart';
import 'package:movie_ui/model/movie.dart';
import 'package:movie_ui/model/search.dart';
import 'package:movie_ui/service/api_service.dart';
import 'package:movie_ui/pages/detail_movie_page.dart';
import 'package:movie_ui/pages/detail_genre.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Search> _nime = [];
  List<Search> _search = [];

  Future<Null> searchData() async {
    final String urL =
        "https://kusonime-scrapper.glitch.me/api/genres/fantasy/1";
    final response = await http.get(Uri.parse(urL));
    if (response.statusCode == 200) {
      setState(() {
        final data = json.decode(response.body);
        for (Map i in data) {
          _nime.add(Search.fromJson(i));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    searchData();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
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
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                },
              )
            ],
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.home,
                    color: Colors.black45,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black45,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.star,
                    color: Colors.black45,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.help,
                    color: Colors.black45,
                  ),
                )
              ],
            ),
          ),
          backgroundColor: Colors.white,
          body: TabBarView(children: [HomeView(), Genre(), Popular(), About()]),
        ),
      );
}

class HomeView extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeView> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: ListView(
        children: [
          // Popular
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: FutureBuilder(
              future: fantasyGenre(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var animeData = snapshot.data;
                  return Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                      right: 15,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 220,
                          child: Swiper(
                            onIndexChanged: (index) {
                              setState(() {
                                _current = index;
                              });
                            },
                            autoplay: false,
                            layout: SwiperLayout.DEFAULT,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, index) {
                              var link = animeData[index]['id'];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailMoviePage(
                                        link,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: 5,
                                    right: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data[index]['thumb']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 15,
                    ),
                    child: Container(
                      color: Colors.black12,
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          FutureBuilder(
            future: genreAnime(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: 41,
                  margin: EdgeInsets.only(top: 15),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var length = snapshot.data[index]['id'].length;
                      var endpoint =
                          snapshot.data[index]['id'].substring(0, length - 1);
                      print(endpoint);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailGenre(
                                endpoint,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(right: 7),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: Text(
                            snapshot.data[index]['genre_name'],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Text("error");
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Text(
              "On Going",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder(
            future: getNime(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: 190,
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
                            Container(
                              height: 160,
                              width: 180,
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
                              width: 140,
                              child: Text(
                                snapshot.data[index]['title'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            )
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
          // Now Showing
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              "Aksi",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder(
            future: actionGenre(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: 170,
                  margin: EdgeInsets.only(top: 10),
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
                            )
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
          // Continue
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              "Now Showing",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 170,
            margin: EdgeInsets.only(top: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: continueWatching.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 140,
                        width: 110,
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              continueWatching[index].imgPoster,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 110,
                        child: Text(
                          continueWatching[index].title,
                          style: TextStyle(
                            color: black,
                            fontSize: 17,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Genre extends StatefulWidget {
  @override
  _GenreState createState() => _GenreState();
}

class _GenreState extends State<Genre> {
  @override
  Widget build(BuildContext context) {
    return Text("Genre");
  }
}

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  @override
  Widget build(BuildContext context) {
    return Text("Popular");
  }
}

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Text("About");
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final String searchData =
        "https://anime.rifkiystark.tech/api/search/${query}";

    Future searchDatas() async {
      var response = await http.get(Uri.parse(searchData));
      var value = json.decode(response.body);
      return value['search_results'];
    }

    return FutureBuilder(
      future: searchDatas(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final double shortestSide = MediaQuery.of(context).size.shortestSide;
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
                padding: EdgeInsets.only(top: 16),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var link = snapshot.data[index]['id'];
                  var genres = snapshot.data[index]['genre_list'].join(", ");

                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    child: Hero(
                        tag: snapshot.data[index]['title'],
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailMoviePage(
                                  link,
                                ),
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
                                    snapshot.data[index]['title'],
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final String searchData =
        "https://anime.rifkiystark.tech/api/search/${query}";

    Future searchDatas() async {
      var response = await http.get(Uri.parse(searchData));
      var value = json.decode(response.body);
      return value['search_results'];
    }

    return FutureBuilder(
      future: searchDatas(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              var link = snapshot.data[index]['id'];
              return ListTile(
                leading: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                title: Text(snapshot.data[index]['title']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMoviePage(
                        link,
                      ),
                    ),
                  );
                },
              );
            },
            itemCount: snapshot.data.length,
          );
        } else {
          return Text("");
        }
      },
    );
  }
}
