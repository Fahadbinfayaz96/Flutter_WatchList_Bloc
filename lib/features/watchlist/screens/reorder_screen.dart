import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_watchlist_bloc/core/theme.dart';
import 'package:flutter_watchlist_bloc/features/watchlist/bloc/watchlist_bloc.dart';
import 'package:flutter_watchlist_bloc/features/watchlist/bloc/watchlist_event.dart';
import 'package:flutter_watchlist_bloc/features/watchlist/bloc/watchlist_state.dart';
import 'package:flutter_watchlist_bloc/features/watchlist/data/models/stocks_model.dart';
import 'package:flutter_watchlist_bloc/features/watchlist/widgets/list_card_widget.dart';
import 'package:flutter_watchlist_bloc/features/watchlist/widgets/buttons/primary_button.dart';
import 'package:flutter_watchlist_bloc/features/watchlist/widgets/buttons/secondary_button.dart';

import '../widgets/changePercentageCalculator.dart';

class ReorderWatchlistScreen extends StatelessWidget {
  final String watchlistTitle;
  const ReorderWatchlistScreen({super.key, required this.watchlistTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(watchlistTitle)),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                editTile(context, watchlistTitle),
                SizedBox(height: 15.h),
                Expanded(
                  child: BlocBuilder<WatchlistBloc, WatchlistState>(
                    builder: (context, state) {
                      if (state is WatchlistLoadedState) {
                        final stocks = state.stocks;
                        return StockList(stocks: stocks);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary,
                    blurRadius: .1,
                    spreadRadius: .1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SecondaryElevatedButton(
                    buttonText: " Edot other watchlist",
                    onPressed: () {},
                  ),
                  SizedBox(height: 10.h),
                  PrimaryElevatedButton(
                    buttonText: "Save Watchlist",
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  editTile(BuildContext context, watchListTitle) {
    return Container(
      width: double.infinity,
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppTheme.grey200,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: AppTheme.grey300, blurRadius: 1, spreadRadius: 1),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text(
              watchListTitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.grey500,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(Icons.edit, color: AppTheme.grey500),
          ],
        ),
      ),
    );
  }
}

class StockList extends StatefulWidget {
  const StockList({super.key, required this.stocks});

  final List<StocksModel> stocks;

  @override
  State<StockList> createState() => _StockListState();
}

class _StockListState extends State<StockList>
    with SingleTickerProviderStateMixin {
  late final controller = SlidableController(this);
  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      proxyDecorator: (child, index, animation) {
        return Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: AppTheme.grey200,
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: child,
          ),
        );
      },
      itemBuilder: (context, index) {
        return Slidable(
          key: ValueKey(widget.stocks[index].id),
          endActionPane: ActionPane(
            extentRatio: .3,
            motion: const ScrollMotion(),
            children: [
              Container(
                height: 65.h,
                width: 97.w,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Icon(Icons.delete, color: AppTheme.white500),
              ),
            ],
          ),
          child: ListCard(
            key: Key(widget.stocks[index].id),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Icon(
                    Icons.drag_handle,
                    size: 18.sp,
                    color: AppTheme.grey500,
                  ),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.stocks[index].name,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        widget.stocks[index].type,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    Text(
                      widget.stocks[index].price.toString(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),

                      decoration: BoxDecoration(
                        color: widget.stocks[index].change >= 0
                            ? AppTheme.green500
                            : AppTheme.red500,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${widget.stocks[index].change.toString()} (${calculateChangePercent(widget.stocks[index].change, widget.stocks[index].price).toStringAsFixed(2)}%)",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.white500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      itemCount: widget.stocks.length,
      onReorder: (oldIndex, newIndex) {
        BlocProvider.of<WatchlistBloc>(
          context,
        ).add(ReorderStocksEvent(oldIndex: oldIndex, newIndex: newIndex));
      },
    );
  }
}
