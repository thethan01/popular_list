class Movie {
  final String posterPath;
  final String releaseDate;
  final String title;
  final dynamic voteAverage;

  Movie(
      {required this.posterPath,
      required this.releaseDate,
      required this.title,
      required this.voteAverage});
  factory Movie.fromJson(dynamic json) {
    return Movie(
        posterPath: json['poster_path'] as String,
        releaseDate: json['release_date'] as String,
        title: json['title'] as String,
        voteAverage: json['vote_average'] as dynamic);
  }
  static List<Movie> movieFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Movie.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Movie {posterPath: $posterPath, releaseDate: $releaseDate, title: $title, voteAverage: $voteAverage}';
  }
}
