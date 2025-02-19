import 'genre.dart';

class Movie {
  final int id;
  final String title;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final double? rating;
  final DateTime? releaseDate;
  final List<Genre> genres;
  final List<int> genreIds;

  Movie({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.rating,
    this.releaseDate,
    required this.genres,
    required this.genreIds,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? 'No Title',
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      rating: (json['vote_average'] as num?)?.toDouble(),
      releaseDate: json['release_date'] != null
          ? DateTime.tryParse(json['release_date'])
          : null,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((g) => Genre.fromJson(g))
              .toList() ?? 
          [],
      genreIds: (json['genre_ids'] as List<dynamic>?)
              ?.map((id) => id as int)
              .toList() ?? 
          [],
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'id': id,
      'title': title,
      'vote_average': rating,
      'release_date': releaseDate?.toIso8601String(),
      'genres': genres.map((g) => g.toJson()).toList(),
      'genre_ids': genreIds,
    };

    if (overview != null) data['overview'] = overview;
    if (posterPath != null) data['poster_path'] = posterPath;
    if (backdropPath != null) data['backdrop_path'] = backdropPath;

    return data;
  }
}
