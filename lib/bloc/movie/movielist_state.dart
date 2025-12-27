part of 'movielist_bloc.dart';

sealed class MovielistState extends Equatable {
  const MovielistState();

  @override
  List<Object> get props => [];
}

class MovielistInitial extends MovielistState {}

class MovielisLoading extends MovielistState {}

class MovieFetchSuccess extends MovielistState {
  final List<Results> popular;
  final List<Results> toprated;
  final List<Results> nowPlaying;
  final List<Results> upcoming;

  const MovieFetchSuccess({
    required this.popular,
    required this.toprated,
    required this.nowPlaying,
    required this.upcoming,
  });
}

class MovieFailure extends MovielistState {
  final String errorMessage;

  const MovieFailure({required this.errorMessage});
}
