import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_watchlist_bloc/features/watchlist/bloc/watchlist_bloc.dart';
import 'package:flutter_watchlist_bloc/features/watchlist/bloc/watchlist_event.dart';
import 'package:flutter_watchlist_bloc/features/watchlist/bloc/watchlist_state.dart';
import 'package:flutter_watchlist_bloc/features/watchlist/widgets/list_card_widget.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  void initState() {
    BlocProvider.of<WatchlistBloc>(context).add(WatchlistLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        HeaderWidget(
                          title1: "SENSEX 18TH SEP 2026",
                          title2: "BSE",
                        ),
                        SizedBox(height: 12.h),

                        HeaderWidget(
                          title1: "1225.55",
                          title2: "14450(13.3333333)",
                          change: 14450,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 50.sp,
                    child: VerticalDivider(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(width: 10.sp),
                  Expanded(
                    child: Column(
                      children: [
                        HeaderWidget(title1: "NIFTY BANK"),
                        SizedBox(height: 12.sp),
                        HeaderWidget(
                          title1: "35225.54",
                          title2: "-11.3(-02.3221)",

                          change: -11.3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                height: 45.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppTheme.grey200,
                ),
                child: Row(
                  children: [
                    SizedBox(width: 15),
                    Icon(Icons.search, color: AppTheme.grey500),
                    SizedBox(width: 5),
                    Text(
                      "Search for instruments",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.grey500,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(child: Watchlist()),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  final String title1;
  final String? title2;

  final double? change;
  const HeaderWidget({
    super.key,
    required this.title1,
    this.title2,
    this.change,
  });

  getColor() {
    if (change == null) {
      return AppTheme.black500;
    }
    if (change! < 0) {
      return AppTheme.red500;
    }
    if (change! > 0) {
      return AppTheme.green500;
    }
    return AppTheme.grey500;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Text(
            title1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            title2 ?? "",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: getColor(),
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class Watchlist extends StatelessWidget {
  const Watchlist({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            indicatorSize: TabBarIndicatorSize.label,

            dividerColor: Theme.of(context).colorScheme.onSurface,
            labelColor: Theme.of(context).colorScheme.onSurface,
            tabs: const [
              Tab(text: "Watchlist 1"),
              Tab(text: "Watchlist 2"),
              Tab(text: "Watchlist 3"),
            ],
          ),

          Expanded(
            child: TabBarView(
              children: [
                StockList(watchlistTitle: "Watchlist 1"),
                StockList(watchlistTitle: "Watchlist 2"),
                Center(child: Text("coming soon...")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StockList extends StatelessWidget {
  final String watchlistTitle;
  const StockList({super.key, required this.watchlistTitle});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        if (state is WatchlistLoadingState || state is WatchlistInitialState) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          );
        } else if (state is WatchlistLoadedState) {
          final stocks = state.stocks;

          return ListView.builder(
            padding: EdgeInsets.only(top: 20),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.goNamed('reorder', extra: watchlistTitle);
                },
                child: ListCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stocks[index].name,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            stocks[index].type,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),

                      Column(
                        children: [
                          Text(
                            stocks[index].price.toString(),
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 3,
                            ),

                            decoration: BoxDecoration(
                              color: stocks[index].change >= 0
                                  ? AppTheme.green500
                                  : AppTheme.red500,
                              borderRadius: BorderRadius.circular(20),
                            ),

                            child: Text(
                              "${stocks[index].change.toString()}%",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
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

            itemCount: stocks.length,
          );
        } else if (state is WatchlistEmptyState) {
          return Text(state.message);
        } else {
          return Text("Something went wrong");
        }
      },
    );
  }
}
