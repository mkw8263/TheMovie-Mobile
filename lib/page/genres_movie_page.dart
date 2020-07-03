import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:themovie/style/theme.dart' as Style;
import 'package:themovie/blocs/movie_genres_detail_bloc.dart';
import 'package:themovie/models/movie_model.dart';

class GenresMoviePage extends StatefulWidget {
  final int genresId;

  GenresMoviePage({Key key, @required this.genresId}) :super(key: key);

  @override
  State<StatefulWidget> createState() => _GenresMoviePage(genresId);

}

class _GenresMoviePage extends State<GenresMoviePage> {
  final int genresId;

  _GenresMoviePage(this.genresId);

  @override
  void initState() {
    super.initState();
    movieGenresDetailBloc.fetchMovies(genresId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: movieGenresDetailBloc.getMovie,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasData) {
          return _buildList(snapshot.data);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return _buildLoading();
      },
    );
  }

  Widget _buildList(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.isEmpty) {
      return Container(
        child: Text("empty data"),
      );
    } else {
      return Container(
        height: 270.0,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
              child: Column(
                children: [
                  movies[index].poster == null ?
                  Container(
                    width: 120.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                        color: Style.Colors.secondColor,
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        shape: BoxShape.rectangle
                    ),
                    child: Column(
                      children: [
                        Icon(EvaIcons.fileOutline, color: Colors.white,
                            size: 50.0)
                      ],
                    ),
                  ) :
                  Container(
                    width: 120.0,
                    height: 160.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/w200/" +
                                    movies[index].poster),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 100.0,
                    child: Text(
                      movies[index].title,
                      maxLines: 2,
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  RatingBar(
                    itemSize: 8.0,
                    initialRating: movies[index].rating / 2,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) =>
                        Icon(EvaIcons.star, color: Style.Colors.secondColor),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  )
                ],
              ),
            );
          },
        ),
      );
    }
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 4.0),
          )
        ],
      ),
    );
  }
}