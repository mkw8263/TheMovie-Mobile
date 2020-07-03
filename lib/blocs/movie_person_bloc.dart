import 'package:rxdart/rxdart.dart';
import 'package:themovie/models/personeResponse.dart';
import 'package:themovie/repository.dart';

class PersonMoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<PersonResponse>();

  Observable<PersonResponse> get personList => _moviesFetcher.stream;

  fetchPersonList() async {
    PersonResponse itemModel = await _repository.fetchPersonList();
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final personMovieBloc = PersonMoviesBloc();
