import 'package:equatable/equatable.dart';

class WatchlistEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class WatchlistLoadEvent extends WatchlistEvent {}

class ReorderStocksEvent extends WatchlistEvent {
  final int oldIndex;
  final int newIndex;

  ReorderStocksEvent({required this.oldIndex, required this.newIndex});

  @override
  List<Object?> get props => [oldIndex, newIndex];
}
