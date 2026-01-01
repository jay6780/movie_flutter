part of 'tvseriespaging_bloc.dart';

sealed class TvseriespagingEvent extends Equatable {
  final int page;
  final int position;

  const TvseriespagingEvent({required this.page, required this.position});

  @override
  List<Object> get props => [page, position];
}

class TvseriespagingfetchEvent extends TvseriespagingEvent {
  const TvseriespagingfetchEvent({
    required super.page,
    required super.position,
  });
}
