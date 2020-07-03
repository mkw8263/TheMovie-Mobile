import 'package:rxdart/rxdart.dart';
import 'package:themovie/models/movie_model.dart';
import 'package:themovie/repository.dart';

class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<MovieResponse>();

  Observable<MovieResponse> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    MovieResponse itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final movieBloc = MoviesBloc();