import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quakeapp/details.dart';
import 'favorite.dart';
import 'globals.dart';
import 'details.dart';
import "package:quakeapp/database_helper.dart";
import 'favorited.dart';
import 'home.dart';


List<String> coded = ["28", "12", "16", "35", "80", "99", "18", "10751", "14", "36", "27", "10402", "9648", "10749", "878", "10770",
  "53", "10752", "37", "[", "]"]; //ABV list
List<String> decoded = ["Action", "Adventure", "Animation", "Comedy", "Crime", "Documentary", "Drama", "Family", "Fantasy", "History",
  "Horror", "Music", "Mystery", "Romance", "Science Fiction", "TV Movie", "Thriller", "War", "Western", "", ""]; //corresponding list
Map<String, String> map = new Map.fromIterables(coded, decoded);






class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {


  var db = new DatabaseHelper();

  final List<Favorite> _itemList = <Favorite>[];



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey,

      body: Column(
        children: <Widget>[
          ButtonBar(
            children: <Widget>[
              RaisedButton(
                onPressed: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context) => Favorited()));

                },
                child: Text('Favorites'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 100,
                padding: const EdgeInsets.all(4.4),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int position) {
                  //crating the rows for our listview
                  if (position.isOdd) return new Divider();
                  final index = position ~/
                      2; // we are dividing position by 2 and returning an integer result
                  String poster = totalPackage[index]["poster_path"];
                  String txt = totalPackage[index]['genre_ids'].toString();



                  final result = map.entries
                      .fold(txt, (prev, e) => prev.replaceAll(e.key, e.value));

                  if (poster == null) {
                    poster =
                    'https://pngimage.net/wp-content/uploads/2018/06/no-image-available-png-3.png';
                  } else {
                    poster =
                    'https://image.tmdb.org/t/p/w500/${totalPackage[index]["poster_path"]}';
                  }

                  return GestureDetector(
                    onTap: (){

                      backdropPath = 'https://image.tmdb.org/t/p/w500/${totalPackage[index]["backdrop_path"]}';
                      overview = totalPackage[index]["overview"];
                      posterglobal = poster;
                      titleglobal = totalPackage[index]['title'];
                      releaseglobal = totalPackage[index]['release_date'];
                      genreglobal = result;


                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => details()));


                    },
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: 230,
                              child: Container(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20.0,
                          top: 25.0,
                          child: LimitedBox(
                            maxWidth: MediaQuery.of(context).size.width * 0.45,
                            maxHeight: MediaQuery.of(context).size.width * 0.45,
                            child: Container(
                              child: Image.network(poster
                                //        'https://image.tmdb.org/t/p/w500/oFbrPffgM94psqkdxiXMTlCvCtU.jpg'
                                //    'https://image.tmdb.org/t/p/w500/${_results[position]["poster_path"]}',
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 160.0,
                          top: 25.0,
                          width: MediaQuery.of(context).size.width * 0.50,
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            color: Colors.green,
                            child: Text(
                              'Release: ${totalPackage[index]['release_date']}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 160.0,
                          top: 80.0,
                          width: MediaQuery.of(context).size.width * 0.50,
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            color: Colors.yellow,
                            child: Text(
                              'Genre: $result',
                              style: TextStyle(color: Colors.black),
                              softWrap: true,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 160.0,
                          top: 140.0,
                          width: MediaQuery.of(context).size.width * 0.50,
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            color: Colors.red,
                            child: Text(
                              'Title: ${totalPackage[index]['title']}',
                              style: TextStyle(color: Colors.white),
                              softWrap: true,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 160.0,
                          top: 200.0,
                          width: MediaQuery.of(context).size.width * 0.50,
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            color: Colors.blue,
                            child: Text(
                              'Add to Favorites',
                              style: TextStyle(color: Colors.white),
                              softWrap: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Future<Map> getPage01() async {
    String apiUrl =
        "https://api.themoviedb.org/3/discover/movie?api_key=1f54bd990f1cdfb230adb312546d765d&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1";
    http.Response response = await http.get(apiUrl);

    return json.decode(response.body);
  }

  Future<Map> getPage02() async {
    String apiUrl =
        "https://api.themoviedb.org/3/discover/movie?api_key=1f54bd990f1cdfb230adb312546d765d&language=en-US&sort_by=release_date.desc&include_adult=false&include_video=false&page=2";

    http.Response response = await http.get(apiUrl);

    return json.decode(response.body);
  }

  Future<Map> getPage03() async {
    String apiUrl =
        "https://api.themoviedb.org/3/discover/movie?api_key=1f54bd990f1cdfb230adb312546d765d&language=en-US&sort_by=release_date.desc&include_adult=false&include_video=false&page=3";

    http.Response response = await http.get(apiUrl);

    return json.decode(response.body);
  }

  Future<Map> getGenres() async {
    String apiUrl =
        "https://api.themoviedb.org/3/genre/movie/list?api_key=1f54bd990f1cdfb230adb312546d765d&language=en-US";

    http.Response response = await http.get(apiUrl);

    return json.decode(response.body);
  }
}
