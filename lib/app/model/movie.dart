import 'dart:convert';

Movie movieFromJson(String str) => Movie.fromJson(json.decode(str));
String movieToJson(Movie data) => json.encode(data.toJson());

class Movie {
  List<Results> results = [];

  Movie({required this.results});

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    results: List<Results>.from(
      json["results"].map((x) => Results.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Results {
  bool? adult;
  String? backdropPath;
  int? id;
  String? title;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? mediaType;
  String? originalLanguage;
  double? popularity;
  String? releaseDate;
  bool? video;
  double? voteAverage;
  int? voteCount;
  List<int> genreIds;
  String? originalName;

  Results({
    this.adult,
    this.backdropPath,
    this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.originalLanguage,
    this.popularity,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
    List<int>? genreIds,
    this.originalName,
  }) : genreIds = genreIds ?? [];

  get getAdult => this.adult;

  set setAdult(adult) => this.adult = adult;

  get getBackdropPath => this.backdropPath;

  set setBackdropPath(backdropPath) => this.backdropPath = backdropPath;

  get getId => this.id;

  set setId(id) => this.id = id;

  get getTitle => this.title;

  set setTitle(title) => this.title = title;

  get getOriginalTitle => this.originalTitle;

  set setOriginalTitle(originalTitle) => this.originalTitle = originalTitle;

  get getOverview => this.overview;

  set setOverview(overview) => this.overview = overview;

  get getPosterPath => this.posterPath;

  set setPosterPath(posterPath) => this.posterPath = posterPath;

  get getMediaType => this.mediaType;

  set setMediaType(mediaType) => this.mediaType = mediaType;

  get getOriginalLanguage => this.originalLanguage;

  set setOriginalLanguage(originalLanguage) =>
      this.originalLanguage = originalLanguage;

  get getPopularity => this.popularity;

  set setPopularity(popularity) => this.popularity = popularity;

  get getReleaseDate => this.releaseDate;

  set setReleaseDate(releaseDate) => this.releaseDate = releaseDate;

  get getVideo => this.video;

  set setVideo(video) => this.video = video;

  get getVoteAverage => this.voteAverage;

  set setVoteAverage(voteAverage) => this.voteAverage = voteAverage;

  get getVoteCount => this.voteCount;

  set setVoteCount(voteCount) => this.voteCount = voteCount;

  get getGenreIds => this.genreIds;

  set setGenreIds(genreIds) => this.genreIds = genreIds;

  get getOriginalName => this.originalName;

  set setOriginalName(originalName) => this.originalName = originalName;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    adult: json["adult"] as bool?,
    backdropPath: json["backdrop_path"] as String?,
    id: json["id"] as int?,
    title: json["title"] as String?,
    originalTitle: json["original_title"] as String?,
    overview: json["overview"] as String?,
    posterPath: json["poster_path"] as String?,
    mediaType: json["media_type"] as String?,
    originalLanguage: json["original_language"] as String?,
    popularity: (json["popularity"] as num?)?.toDouble(),
    releaseDate: json["release_date"] as String?,
    video: json["video"] as bool?,
    voteAverage: (json["vote_average"] as num?)?.toDouble(),
    voteCount: json["vote_count"] as int?,
    genreIds: json["genre_ids"] != null
        ? List<int>.from(json["genre_ids"].map((x) => x as int))
        : [],
    originalName: json["original_name"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "id": id,
    "title": title,
    "original_title": originalTitle,
    "overview": overview,
    "poster_path": posterPath,
    "media_type": mediaType,
    "original_language": originalLanguage,
    "popularity": popularity,
    "release_date": releaseDate,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "original_name": originalName,
  };
}
