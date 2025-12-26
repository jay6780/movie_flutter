import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:free_movie/app/model/movie.dart';
import 'package:free_movie/app/service/api_service.dart';
import 'dart:async';
part 'movielist_event.dart';
part 'movielist_state.dart';

class MovielistBloc extends Bloc<MovielistEvent, MovielistState> {
  MovielistBloc() : super(MovielistInitial()) {
    on<MoviefetchEvent>(onPopularfetch);
  }

  FutureOr<void> onPopularfetch(
    MoviefetchEvent event,
    Emitter<MovielistState> emit,
  ) async {
    emit(MovielisLoading());
    try {
      var client = ApiService().provideDio();
      var popular = await client.get("movie/popular");
      var toprated = await client.get("movie/top_rated");
      var nowplaying = await client.get("movie/now_playing");
      var upcoming = await client.get("movie/upcoming");
      if (popular.statusCode == 200 &&
          toprated.statusCode == 200 &&
          nowplaying.statusCode == 200 &&
          upcoming.statusCode == 200) {
        final populardata = Movie.fromJson(popular.data);
        final toprateddata = Movie.fromJson(toprated.data);
        final nowplayingdata = Movie.fromJson(nowplaying.data);
        final upcommingdata = Movie.fromJson(upcoming.data);
        emit(
          MovieFetchSuccess(
            popular: populardata.results,
            toprated: toprateddata.results,
            nowPlaying: nowplayingdata.results,
            upcoming: upcommingdata.results,
          ),
        );
      } else {
        emit(
          PopularFailure(errorMessage: "Failed to load: ${popular.statusCode}"),
        );
      }
    } catch (e) {
      emit(PopularFailure(errorMessage: e.toString()));
    }
  }
}
