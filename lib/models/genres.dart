class Genres {
  final int id;
  final String name;

  Genres(this.id, this.name);

  Genres.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];
}

class GenresResponse {
  final List<Genres> genres;
  final String error;

  GenresResponse(this.genres, this.error);

  GenresResponse.fromJson(Map<String, dynamic> json)
      : genres =
            (json["genres"] as List).map((i) => Genres.fromJson(i)).toList(),
        error = "";

  GenresResponse.withError(String errorValue)
      : genres = List(),
        error = errorValue;
}
