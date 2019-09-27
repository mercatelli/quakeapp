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


class Favorited extends StatefulWidget {
  @override
  _FavoritedState createState() => _FavoritedState();
}

class _FavoritedState extends State<Favorited> {


  var db = new DatabaseHelper();
  final List<Favorite> _itemList = <Favorite>[];


  @override
  void initState() {
    super.initState();

    _readFavoritedList();
  }
  
  
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
                padding: new EdgeInsets.all(8.0),
                reverse: false,
                itemCount: _itemList.length,
                itemBuilder: (_, int index) {
                  return new Card(
                    color: Colors.white10,
                    child: new ListTile(
                      title: _itemList[index],
                      onTap: (){

                        print("Genre: ${(_itemList[index]).genre}");
                        print("Movie: ${(_itemList[index]).title}");
                        print("Release: ${(_itemList[index]).release}");
                        print("Poster link: ${(_itemList[index]).poster}");

                    /*    backdropPath = 'https://image.tmdb.org/t/p/w500/${totalPackage[index]["backdrop_path"]}';
                        overview = totalPackage[index]["overview"];
                        posterglobal = poster;
                        titleglobal = totalPackage[index]['title'];
                        releaseglobal = totalPackage[index]['release_date'];
                        genreglobal = result;


                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => details()));*/


                      },
                      trailing: new Listener(
                        key: new Key(_itemList[index].title),
                        child:  new Icon(Icons.remove_circle,
                          color: Colors.redAccent,),
                        onPointerDown: (pointerEvent) =>
                            _deleteNoDo(_itemList[index].id, index),
                      ),
                    ),
                  );

                }),
          ),

          new Divider(
            height: 1.0,
          )
        ],
      ),
    );
  }

  _readFavoritedList() async {
    List items = await db.getAllFavorites();
    items.forEach((item) {
      // NoDoItem noDoItem = NoDoItem.fromMap(item);
      setState(() {
        _itemList.add(Favorite.map(item));
      });
      // print("Db items: ${noDoItem.itemName}");
    });

  }

  _deleteNoDo(int id, int index) async {
    debugPrint("Deleted Item!");

    await db.deleteFavorite(id);
    setState(() {
      _itemList.removeAt(index);
    });


  }
}
