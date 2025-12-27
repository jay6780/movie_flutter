part of 'moviepagination_bloc.dart';

sealed class MoviepaginationEvent extends Equatable {
  final int page;
  final int position;

  const MoviepaginationEvent({required this.page, required this.position});

  @override
  List<Object> get props => [page, position];
}

class MoviepaginationfetchEvent extends MoviepaginationEvent {
  const MoviepaginationfetchEvent({
    required super.page,
    required super.position,
  });
}
