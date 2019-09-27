import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'database_helper.dart';
import 'favorite.dart';
import 'globals.dart';

class details extends StatefulWidget {
  @override
  _detailsState createState() => _detailsState();
}

class _detailsState extends State<details> {

  var db = new DatabaseHelper();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text("Movies"),
          backgroundColor: Colors.blueGrey,
        ),
        body:FittedBox(

          child: Container(

            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.network(backdropPath),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: MediaQuery.of(context).size.width*1.1,


                    child: Text(
                        overview,
                        style: TextStyle(fontSize: 20.0,),
                        softWrap: true,
                        textAlign: TextAlign.justify,
                    ),
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () async {

                        await db.saveFavorite(new Favorite(posterglobal, titleglobal, genreglobal, releaseglobal));

                      },
                      child: Text('Add to Favorites'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),







    );
  }
}

