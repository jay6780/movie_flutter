import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:free_movie/app/model/movie.dart';
import 'dart:async';

import 'package:free_movie/app/service/api_service.dart';
part 'moviepagination_event.dart';
part 'moviepagination_state.dart';

class MoviepaginationBloc
    extends Bloc<MoviepaginationEvent, MoviepaginationState> {
  MoviepaginationBloc() : super(MoviepaginationInitial()) {
    on<MoviepaginationfetchEvent>(_paginateAll);
  }

  FutureOr<void> _paginateAll(
    MoviepaginationfetchEvent event,
    Emitter<MoviepaginationState> emit,
  ) async {
    final List<Results> allList = [];

    emit(MoviepaginationLoading());

    try {
      var client = ApiService().provideDio();
      switch (event.position) {
        case 1:
          var popular = await client.get(
            "movie/popular",
            queryParameters: {'page': event.page},
          );
          if (popular.statusCode == 200) {
            final populardata = Movie.fromJson(popular.data);
            allList.addAll(populardata.results);
          } else {
            emit(
              MoviepaginationFailure(
                errorMessage: "Failed to load: ${popular.statusCode}",
              ),
            );
          }
          break;
        case 2:
          var toprated = await client.get(
            "movie/top_rated",
            queryParameters: {'page': event.page},
          );
          if (toprated.statusCode == 200) {
            final toprateddata = Movie.fromJson(toprated.data);
            allList.addAll(toprateddata.results);
          } else {
            emit(
              MoviepaginationFailure(
                errorMessage: "Failed to load: ${toprated.statusCode}",
              ),
            );
          }
          break;

        case 3:
          var nowplaying = await client.get(
            "movie/now_playing",
            queryParameters: {'page': event.page},
          );
          if (nowplaying.statusCode == 200) {
            final nowplayingdata = Movie.fromJson(nowplaying.data);
            allList.addAll(nowplayingdata.results);
          } else {
            emit(
              MoviepaginationFailure(
                errorMessage: "Failed to load: ${nowplaying.statusCode}",
              ),
            );
          }
          break;

        case 4:
          var upcoming = await client.get(
            "movie/upcoming",
            queryParameters: {'page': event.page},
          );
          if (upcoming.statusCode == 200) {
            final upcommingdata = Movie.fromJson(upcoming.data);

            allList.addAll(upcommingdata.results);
          } else {
            emit(
              MoviepaginationFailure(
                errorMessage: "Failed to load: ${upcoming.statusCode}",
              ),
            );
          }
          break;
      }
      emit(MoviepaginationSuccess(allList: allList));
    } catch (e) {
      emit(MoviepaginationFailure(errorMessage: e.toString()));
    }
  }
}
