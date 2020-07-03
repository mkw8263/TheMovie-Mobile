import 'package:rxdart/rxdart.dart';
import 'package:themovie/models/genres.dart';
import 'package:themovie/models/movie_model.dart';
import 'package:themovie/repository.dart';

class MovieGenresDetailBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<MovieResponse>();

  Observable<MovieResponse> get getMovie => _moviesFetcher.stream;

  fetchMovies(int id) async {
    MovieResponse itemModel = await _repository.fetchDetailGenres(id);
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final movieGenresDetailBloc = MovieGenresDetailBloc();
