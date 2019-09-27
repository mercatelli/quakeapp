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


Map _data01;
Map _data02;
Map _data03;
Map _genres;
List _results01;
List _results02;
List _results03;
List _genresResults;
List _favorites;


void main() async {
  _data01 = await getPage01();
  _results01 = _data01['results'];

  _data02 = await getPage02();
  _results02 = _data02['results'];

  _data03 = await getPage03();
  _results03 = _data03['results'];

  _genres = await getGenres();
  _genresResults = _genres['genres'];

 totalPackage = _results01 + _results02 + _results03;

 var db = new DatabaseHelper();

  final List<Favorite> _itemList = <Favorite>[];

  //await db.saveFavorite(new Favorite("poster thor", "Thor", "Ação", "04.04.2040"));

 int count = await db.getCount();
 print("Count: $count");

 Favorite aranha = await db.getFavorite(1);

 Favorite aranhaUpdated = Favorite.fromMap(
   {
     "poster" : "poster aranha 2",
     "title" : "Aranha 2",
     "genre" : "Comédia",
     "release" : "09.09.2099",
     "id" : 1
   }
 );

 await db.updateFavorite((aranhaUpdated));

 //print("Got title: ${aranha.title}");


 //int favoriteDeleted = await db.deleteFavorite(8);
 // print("Deleted Favorite: $favoriteDeleted");


_favorites = await db.getAllFavorites();
for (int i = 0; i < _favorites.length; i++) {
  Favorite favorite = Favorite.map(_favorites[i]);
  print ("Favorite: ${favorite.title}, favorite id: ${favorite.id}");

}




  print(_genresResults.asMap().toString());
  print(totalPackage.length);
  print(_genresResults);
  print(_results03[0]['title']);
  print(_results01[0]['poster_path']);
  print(_results01[0]['genre_ids']);
  print(_results01[0]['release_date']);

  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
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


