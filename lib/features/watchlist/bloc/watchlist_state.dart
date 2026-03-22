import 'package:equatable/equatable.dart';
import 'package:flutter_watchlist_bloc/features/watchlist/data/models/stocks_model.dart';

sealed class WatchlistState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WatchlistInitialState extends WatchlistState {}

class WatchlistLoadingState extends WatchlistState {}

class WatchlistLoadedState extends WatchlistState {
  final List<StocksModel> stocks;

  WatchlistLoadedState({required this.stocks});
  @override
  List<Object?> get props => [stocks];
}

class WatchlistEmptyState extends WatchlistState {
  final String message;

  WatchlistEmptyState({required this.message});

  @override
  List<Object?> get props => [message];
}

class WatchlistErrorState extends WatchlistState {
  final String error;

  WatchlistErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
