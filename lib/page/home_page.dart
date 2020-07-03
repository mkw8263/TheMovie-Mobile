import 'package:flutter/material.dart';
import 'package:themovie/page/banner_pay_page.dart';

import 'genres_page.dart';
import 'movie_person_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF151C26),
        appBar: AppBar(
          title: Text("The Movie",
              style: TextStyle(fontSize: 16, color: Colors.white)),
          backgroundColor: Color(0xFF151C26),
          centerTitle: true,
          leading: Icon(Icons.menu, color: Colors.white),
          actions: [
            IconButton(
                icon: Icon(Icons.search, color: Colors.white), onPressed: null)
          ],
        ),
        body: ListView(
          children: [BannerPlayPage(), GenresPage(), MoviePersonListPage()],
        ));
  }
}
