import 'package:rxdart/rxdart.dart';
import 'package:themovie/models/genres.dart';
import 'package:themovie/models/movie_model.dart';
import 'package:themovie/repository.dart';

class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<GenresResponse>();

  Observable<GenresResponse> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    GenresResponse itemModel = await _repository.fetchGenresList();
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final movieBloc = MoviesBloc();
