import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themovie/models/genres.dart';
import 'package:themovie/style/theme.dart' as Style;

import 'genres_movie_page.dart';

class GenresListPage extends StatefulWidget {
  final List<Genres> genres;

  GenresListPage({Key key, @required this.genres}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GenresListPage(genres);
}

class _GenresListPage extends State<GenresListPage>
    with SingleTickerProviderStateMixin {
  final List<Genres> genres;
  TabController _tabController;

  _GenresListPage(this.genres);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: genres.length);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340.0,
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
          backgroundColor: Style.Colors.mainColor,
          appBar: AppBar(
            backgroundColor: Style.Colors.mainColor,
            bottom: TabBar(
                controller: _tabController,
                indicatorColor: Style.Colors.secondColor,
                indicatorWeight: 3.0,
                unselectedLabelColor: Style.Colors.titleColor,
                labelColor: Colors.white,
                isScrollable: true,
                tabs: genres.map((Genres genre) {
                  return Container(
                      padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                      child: Text(genre.name.toUpperCase(),
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold)));
                }).toList()),
          ),
          body: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: genres.map((Genres genres) {
                return GenresMoviePage(genresId: genres.id);
              }).toList()
          ),
        ),
      ),
    );
  }
}
