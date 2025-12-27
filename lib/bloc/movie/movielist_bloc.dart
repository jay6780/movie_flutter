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
    final List<Results> popularlist = [];
    final List<Results> topratedlist = [];
    final List<Results> nowPlayinglist = [];
    final List<Results> upcominglist = [];

    emit(MovielisLoading());
    if (event.page == 1) {
      popularlist.clear();
      topratedlist.clear();
      nowPlayinglist.clear();
      upcominglist.clear();
    }
    try {
      var client = ApiService().provideDio();
      var popular = await client.get(
        "movie/popular",
        queryParameters: {'page': event.page},
      );
      var toprated = await client.get(
        "movie/top_rated",
        queryParameters: {'page': event.page},
      );
      var nowplaying = await client.get(
        "movie/now_playing",
        queryParameters: {'page': event.page},
      );
      var upcoming = await client.get(
        "movie/upcoming",
        queryParameters: {'page': event.page},
      );
      if (popular.statusCode == 200 &&
          toprated.statusCode == 200 &&
          nowplaying.statusCode == 200 &&
          upcoming.statusCode == 200) {
        final populardata = Movie.fromJson(popular.data);
        final toprateddata = Movie.fromJson(toprated.data);
        final nowplayingdata = Movie.fromJson(nowplaying.data);
        final upcommingdata = Movie.fromJson(upcoming.data);

        popularlist.addAll(populardata.results);
        topratedlist.addAll(toprateddata.results);
        nowPlayinglist.addAll(nowplayingdata.results);
        upcominglist.addAll(upcommingdata.results);

        emit(
          MovieFetchSuccess(
            popular: popularlist,
            toprated: topratedlist,
            nowPlaying: nowPlayinglist,
            upcoming: upcominglist,
          ),
        );
      } else {
        emit(
          MovieFailure(errorMessage: "Failed to load: ${popular.statusCode}"),
        );
      }
    } catch (e) {
      emit(MovieFailure(errorMessage: e.toString()));
    }
  }
}
