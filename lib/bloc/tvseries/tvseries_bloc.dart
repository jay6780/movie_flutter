import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:free_movie/app/model/tvseries.dart';
import 'dart:async';
import 'package:free_movie/app/service/api_service.dart';
part 'tvseries_event.dart';
part 'tvseries_state.dart';

class TvseriesBloc extends Bloc<TvseriesEvent, TvseriesState> {
  TvseriesBloc() : super(TvseriesInitial()) {
    on<TvseriesfetchEvent>(onTvSeriesFetch);
  }
  FutureOr<void> onTvSeriesFetch(
    TvseriesfetchEvent event,
    Emitter<TvseriesState> emit,
  ) async {
    final List<Results> tvairinglist = [];
    final List<Results> tvontheairlist = [];
    final List<Results> tvpopularlist = [];
    final List<Results> tvtopratedlist = [];

    emit(TvseriesLoading());

    if (event.page == 1) {
      tvairinglist.clear();
      tvontheairlist.clear();
      tvpopularlist.clear();
      tvtopratedlist.clear();
    }
    try {
      var client = ApiService().provideDio();
      var tvairing = await client.get(
        "tv/airing_today",
        queryParameters: {'page': event.page},
      );
      var tvontheair = await client.get(
        "tv/on_the_air",
        queryParameters: {'page': event.page},
      );
      var tvpopular = await client.get(
        "tv/popular",
        queryParameters: {'page': event.page},
      );
      var tvtoprated = await client.get(
        "tv/top_rated",
        queryParameters: {'page': event.page},
      );
      if (tvairing.statusCode == 200 &&
          tvontheair.statusCode == 200 &&
          tvpopular.statusCode == 200 &&
          tvtoprated.statusCode == 200) {
        final tvairingdata = Tvseries.fromJson(tvairing.data);
        final tvontheairdata = Tvseries.fromJson(tvontheair.data);
        final tvpopulargdata = Tvseries.fromJson(tvpopular.data);
        final tvtoprateddata = Tvseries.fromJson(tvtoprated.data);

        tvairinglist.addAll(tvairingdata.results);
        tvontheairlist.addAll(tvontheairdata.results);
        tvpopularlist.addAll(tvpopulargdata.results);
        tvtopratedlist.addAll(tvtoprateddata.results);
        emit(
          TvseriesSuccess(
            airing: tvairinglist,
            ontheair: tvontheairlist,
            popular: tvpopularlist,
            toprated: tvtopratedlist,
          ),
        );
      } else {
        emit(
          TvseriesFailure(
            errorMessage: "Failed to load: ${tvairing.statusCode}",
          ),
        );
      }
    } catch (e) {
      emit(TvseriesFailure(errorMessage: e.toString()));
    }
  }
}
