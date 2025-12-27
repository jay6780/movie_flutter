import 'dart:convert';

Tvseries tvSeriesFromJson(String str) => Tvseries.fromJson(json.decode(str));
String tvSeriesToJson(Tvseries data) => json.encode(data.toJson());

class Tvseries {
  List<Results> results = [];

  Tvseries({required this.results});

  factory Tvseries.fromJson(Map<String, dynamic> json) => Tvseries(
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
  List<int> genreIds;
  int? id;
  List<String> originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? firstAirDate;

  String? name;
  double? voteAverage;
  int? voteCount;

  Results({
    this.adult,
    this.backdropPath,
    List<int>? genreIds,
    this.id,
    List<String>? originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.firstAirDate,
    this.name,
    this.voteAverage,
    this.voteCount,
  }) : genreIds = genreIds ?? [],
       originCountry = originCountry ?? [];

  String? get getBackdropPath => backdropPath;
  set setBackdropPath(String? value) => backdropPath = value;

  String? get getFirstAirDate => this.firstAirDate;

  set setFirstAirDate(String? firstAirDate) => this.firstAirDate = firstAirDate;

  int? get getId => id;
  set setId(int? value) => id = value;

  String? get getName => name;
  set setName(String? value) => name = value;

  String? get getOriginalLanguage => originalLanguage;
  set setOriginalLanguage(String? value) => originalLanguage = value;

  String? get getOriginalName => originalName;
  set setOriginalName(String? value) => originalName = value;

  String? get getOverview => overview;
  set setOverview(String? value) => overview = value;

  double? get getPopularity => popularity;
  set setPopularity(double? value) => popularity = value;

  String? get getPosterPath => posterPath;
  set setPosterPath(String? value) => posterPath = value;

  double? get getVoteAverage => voteAverage;
  set setVoteAverage(double? value) => voteAverage = value;

  int? get getVoteCount => voteCount;
  set setVoteCount(int? value) => voteCount = value;

  List<int> get getGenreIds => genreIds;
  set setGenreIds(List<int> value) => genreIds = value;

  List<String> get getOriginCountry => originCountry;
  set setOriginCountry(List<String> value) => originCountry = value;

  bool? get getAdult => adult;
  set setAdult(bool? value) => adult = value;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    adult: json["adult"] as bool?,
    backdropPath: json["backdrop_path"] as String?,
    genreIds: json["genre_ids"] != null
        ? List<int>.from(json["genre_ids"].map((x) => x as int))
        : [],
    id: json["id"] as int?,
    originCountry: json["origin_country"] != null
        ? List<String>.from(json["origin_country"].map((x) => x as String))
        : [],
    originalLanguage: json["original_language"] as String?,
    originalName: json["original_name"] as String?,
    overview: json["overview"] as String?,
    popularity: (json["popularity"] as num?)?.toDouble(),
    posterPath: json["poster_path"] as String?,
    firstAirDate: json["first_air_date"] as String?,
    name: json["name"] as String?,
    voteAverage: (json["vote_average"] as num?)?.toDouble(),
    voteCount: json["vote_count"] as int?,
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "first_air_date": firstAirDate,
    "name": name,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
