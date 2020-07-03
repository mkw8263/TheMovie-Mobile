import 'package:flutter/material.dart';
import 'package:themovie/page/home_page.dart';

void main() {
  runApp(MovieMainPage());
}

class MovieMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
