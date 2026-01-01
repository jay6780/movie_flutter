part of 'tvseriespaging_bloc.dart';

sealed class TvseriespagingState extends Equatable {
  const TvseriespagingState();

  @override
  List<Object> get props => [];
}

final class TvseriespagingInitial extends TvseriespagingState {}

class TvseriespagingLoading extends TvseriespagingState {}

final class TvseriespagingSuccess extends TvseriespagingState {
  final List<Results> allList;
  const TvseriespagingSuccess({required this.allList});
}

class TvseriespagingFailure extends TvseriespagingState {
  final String errorMessage;

  const TvseriespagingFailure({required this.errorMessage});
}
