part of 'tvseries_bloc.dart';

sealed class TvseriesState extends Equatable {
  const TvseriesState();

  @override
  List<Object> get props => [];
}

class TvseriesInitial extends TvseriesState {}

class TvseriesLoading extends TvseriesState {}

class TvseriesSuccess extends TvseriesState {
  final List<Results> airing;
  final List<Results> ontheair;
  final List<Results> popular;
  final List<Results> toprated;

  const TvseriesSuccess({
    required this.airing,
    required this.ontheair,
    required this.popular,
    required this.toprated,
  });
}

class TvseriesFailure extends TvseriesState {
  final String errorMessage;

  const TvseriesFailure({required this.errorMessage});
}
