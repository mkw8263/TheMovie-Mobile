import 'dart:async';
import 'package:themovie/models/movie_model.dart';
import 'package:themovie/models/personeResponse.dart';
import 'package:themovie/movie_provider.dart';

import 'models/genres.dart';

class Repository {
  final moviesApiProvider = MovieApiProvider();

  Future<MovieResponse> fetchAllMovies() => moviesApiProvider.fetchMovieList();
  Future<MovieResponse> fetchPlayingList() => moviesApiProvider.fetchPlayingList();
  Future<GenresResponse> fetchGenresList() => moviesApiProvider.fetchGenresList();
  Future<MovieResponse> fetchDetailGenres(int id) => moviesApiProvider.fetchDetailGenres(id);
  Future<PersonResponse> fetchPersonList() => moviesApiProvider.fetchPersonList();
}
