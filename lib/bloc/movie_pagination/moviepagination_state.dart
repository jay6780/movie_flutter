part of 'moviepagination_bloc.dart';

sealed class MoviepaginationState extends Equatable {
  const MoviepaginationState();

  @override
  List<Object> get props => [];
}

class MoviepaginationInitial extends MoviepaginationState {}

class MoviepaginationLoading extends MoviepaginationState {}

final class MoviepaginationSuccess extends MoviepaginationState {
  final List<Results> allList;
  const MoviepaginationSuccess({required this.allList});
}

class MoviepaginationFailure extends MoviepaginationState {
  final String errorMessage;

  const MoviepaginationFailure({required this.errorMessage});
}
