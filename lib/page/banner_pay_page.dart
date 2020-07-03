import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:themovie/blocs/movie_play_bloc.dart';
import 'package:themovie/models/movie_model.dart';
import 'package:themovie/style/theme.dart' as Style;

class BannerPlayPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BannerPlayPage();
}

class _BannerPlayPage extends State<BannerPlayPage> {
  final controller = PageController(viewportFraction: 0.8);

  @override
  void initState() {
    super.initState();
    payMovieBloc.fetchPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: payMovieBloc.playingMovies,
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
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text("empty Data")],
        ),
      );
    } else {
      return Container(
        height: 250,
        child: PageIndicatorContainer(
          align: IndicatorAlign.bottom,
          indicatorColor: Style.Colors.titleColor,
          indicatorSelectorColor: Style.Colors.secondColor,
          indicatorSpace: 0.0,
          shape: IndicatorShape.circle(size: 5.0),
          padding: EdgeInsets.all(5.0),
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.take(5).length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w185${movies[index].backPoster}'),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0xFF151C26).withOpacity(1.0),
                              Color(0xFF151C26).withOpacity(0.0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0.0, 0.9])),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Icon(Icons.play_circle_outline,
                        color: Style.Colors.secondColor, size: 40.0),
                  ),
                  Positioned(
                      bottom: 30.0,
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        width: 250.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movies[index].title,
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            )
                          ],
                        ),
                      ))
                ],
              );
            },
          ),
          length: movies.take(5).length,
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
