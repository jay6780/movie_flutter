import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:free_movie/app/model/tvseries.dart';
import 'package:free_movie/app/service/api_service.dart';
part 'tvseriespaging_event.dart';
part 'tvseriespaging_state.dart';

class TvseriespagingBloc
    extends Bloc<TvseriespagingEvent, TvseriespagingState> {
  TvseriespagingBloc() : super(TvseriespagingInitial()) {
    on<TvseriespagingfetchEvent>(_paginateAll);
  }
  FutureOr<void> _paginateAll(
    TvseriespagingfetchEvent event,
    Emitter<TvseriespagingState> emit,
  ) async {
    final List<Results> allList = [];

    emit(TvseriespagingInitial());

    try {
      var client = ApiService().provideDio();
      switch (event.position) {
        case 1:
          var airing_today = await client.get(
            "tv/airing_today",
            queryParameters: {'page': event.page},
          );
          if (airing_today.statusCode == 200) {
            final airngdata = Tvseries.fromJson(airing_today.data);
            allList.addAll(airngdata.results);
          } else {
            emit(
              TvseriespagingFailure(
                errorMessage: "Failed to load: ${airing_today.statusCode}",
              ),
            );
          }
          break;
        case 2:
          var on_the_air = await client.get(
            "tv/on_the_air",
            queryParameters: {'page': event.page},
          );
          if (on_the_air.statusCode == 200) {
            final ontheairData = Tvseries.fromJson(on_the_air.data);
            allList.addAll(ontheairData.results);
          } else {
            emit(
              TvseriespagingFailure(
                errorMessage: "Failed to load: ${on_the_air.statusCode}",
              ),
            );
          }
          break;

        case 3:
          var popular = await client.get(
            "tv/popular",
            queryParameters: {'page': event.page},
          );
          if (popular.statusCode == 200) {
            final nowplayingdata = Tvseries.fromJson(popular.data);
            allList.addAll(nowplayingdata.results);
          } else {
            emit(
              TvseriespagingFailure(
                errorMessage: "Failed to load: ${popular.statusCode}",
              ),
            );
          }
          break;

        case 4:
          var top_rated = await client.get(
            "tv/top_rated",
            queryParameters: {'page': event.page},
          );
          if (top_rated.statusCode == 200) {
            final toprateddata = Tvseries.fromJson(top_rated.data);

            allList.addAll(toprateddata.results);
          } else {
            emit(
              TvseriespagingFailure(
                errorMessage: "Failed to load: ${top_rated.statusCode}",
              ),
            );
          }
          break;
      }

      emit(TvseriespagingSuccess(allList: allList));
    } catch (e) {
      emit(TvseriespagingFailure(errorMessage: e.toString()));
    }
  }
}
