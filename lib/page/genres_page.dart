import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themovie/blocs/movie_genres_bloc.dart';
import 'package:themovie/models/genres.dart';
import 'package:themovie/page/geners_list_page.dart';

class GenresPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GenresPage();
}

class _GenresPage extends State<GenresPage> {
  @override
  void initState() {
    super.initState();
    movieBloc.fetchAllMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenresResponse>(
      stream: movieBloc.allMovies,
      builder: (context, AsyncSnapshot<GenresResponse> snapshot) {
        if (snapshot.hasData) {
          return _buildList(snapshot.data);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return _buildLoading();
      },
    );
  }

  Widget _buildList(GenresResponse data) {
    List<Genres> geners = data.genres;
    if (geners.isEmpty) {
      return Container(
        child: Text("not find data"),
      );
    } else
      return GenresListPage(genres: geners);
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
