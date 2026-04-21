import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_watchlist_bloc/features/watchlist/bloc/watchlist_event.dart';
import 'package:flutter_watchlist_bloc/features/watchlist/bloc/watchlist_state.dart';
import 'package:flutter_watchlist_bloc/features/watchlist/data/models/stocks_model.dart';
import 'package:flutter_watchlist_bloc/features/watchlist/data/stocks_data.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc() : super(WatchlistInitialState()) {
    on<WatchlistLoadEvent>((event, emit) {
      emit(WatchlistLoadingState());

      try {
        final stocks = StocksData.stocks;
        if (stocks.isNotEmpty) {
          emit(WatchlistLoadedState(stocks: stocks));
        } else if (stocks.isEmpty) {
          emit(WatchlistEmptyState(message: "No stock found"));
        } else {
          emit(WatchlistErrorState(error: "Something went wrong"));
        }
      } catch (e) {
        emit(WatchlistErrorState(error: e.toString()));
      }
    });

    on<ReorderStocksEvent>((event, emit) {
      if (state is WatchlistLoadedState) {
        final currentState = state as WatchlistLoadedState;
        final updatedStockList = List<StocksModel>.from(currentState.stocks);

        int oldIndex = event.oldIndex;
        int newIndex = event.newIndex;

        if (newIndex > oldIndex) {
          newIndex--;
        }

        final item = updatedStockList.removeAt(oldIndex);
        updatedStockList.insert(newIndex, item);

        emit(WatchlistLoadedState(stocks: updatedStockList));
      }
    });
  }
}
