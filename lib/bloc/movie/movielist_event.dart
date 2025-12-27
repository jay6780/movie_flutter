part of 'movielist_bloc.dart';

sealed class MovielistEvent extends Equatable {
  final int page;
  const MovielistEvent({required this.page});

  @override
  List<Object> get props => [page];
}

class MoviefetchEvent extends MovielistEvent {
  const MoviefetchEvent({required super.page});
}
