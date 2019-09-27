import 'package:flutter/material.dart';

class Favorite extends StatelessWidget {
  String _poster;
  String _title;
  String _release;
  String _genre;
  int _id;


  Favorite(this._poster, this._title, this._genre, this._release);

  Favorite.map(dynamic obj) {
    this._poster = obj['poster'];
    this._title = obj['title'];
    this._genre = obj['genre'];
    this._release = obj['release'];
    this._id = obj['id'];
  }

  String get poster => _poster;
  String get title => _title;
  String get genre => _genre;
  String get release => _release;
  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["poster"] = _poster;
    map["title"] = _title;
    map["genre"] = _genre;
    map["release"] = _release;

    if (id != null) {
      map["id"] = _id;
    }

    return map;
  }

  Favorite.fromMap(Map<String, dynamic> map) {
    this._poster = map["poster"];
    this._title = map["title"];
    this._genre = map["genre"];
    this._release = map["release"];
    this._id = map["id"];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(_title,
                style: new TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.9
                ),),

              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text("Released on: $_release",
                  style: new TextStyle(
                      color:  Colors.white70,
                      fontSize: 12.5,
                      fontStyle:  FontStyle.italic
                  ),),

              )


            ],
          ),



        ],
      ),
    );
  }






}