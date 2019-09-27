import 'package:flutter/material.dart';

import 'first_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.black54,
      ),
      body: FirstScreen(),
    );
  }
}