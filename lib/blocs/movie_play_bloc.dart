import 'package:rxdart/rxdart.dart';
import 'package:themovie/models/movie_model.dart';
import 'package:themovie/repository.dart';

class PlayMoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<MovieResponse>();

  Observable<MovieResponse> get playingMovies => _moviesFetcher.stream;

  fetchPlayingMovies() async {
    MovieResponse itemModel = await _repository.fetchPlayingList();
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final payMovieBloc = PlayMoviesBloc();