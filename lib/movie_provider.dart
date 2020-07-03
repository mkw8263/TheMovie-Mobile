import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:themovie/secret.dart';
import 'dart:convert';
import 'package:themovie/models/movie_model.dart';
import 'package:themovie/models/personeResponse.dart';

import 'models/genres.dart';

class MovieApiProvider {
  Client client = Client();

  Future<MovieResponse> fetchMovieList() async {
    print("entered");
    final response = await client
        .get("http://api.themoviedb.org/3/movie/popular?api_key=${Secret.api_key}");
    print(response.body.toString());
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<GenresResponse> fetchGenresList() async {
    final response = await client
        .get("http://api.themoviedb.org/3/genre/movie/list?api_key=${Secret.api_key}");
    print(response.body.toString());
    if (response.statusCode == 200) {
      return GenresResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<MovieResponse> fetchDetailGenres(int id) async {
    final response = await client.get(
        "http://api.themoviedb.org/3/discover/movie?api_key=${Secret.api_key}&page=1&with_genres=$id");
    print(response.body.toString());
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }


  Future<PersonResponse> fetchPersonList() async {
    final response = await client.get(
        "http://api.themoviedb.org/3/trending/person/week?api_key=${Secret.api_key}");
    print(response.body.toString());
    if (response.statusCode == 200) {
      return PersonResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<MovieResponse> fetchPlayingList() async {
    print("entered");
    final response = await client
        .get("http://api.themoviedb.org/3/movie/now_playing?api_key=${Secret.api_key}");
    print(response.body.toString());
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
