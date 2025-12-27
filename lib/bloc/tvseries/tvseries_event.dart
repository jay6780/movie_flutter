part of 'tvseries_bloc.dart';

sealed class TvseriesEvent extends Equatable {
  final int page;
  const TvseriesEvent({required this.page});

  @override
  List<Object> get props => [page];
}

class TvseriesfetchEvent extends TvseriesEvent {
  const TvseriesfetchEvent({required super.page});
}
