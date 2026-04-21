import 'package:flutter/widgets.dart';
import 'package:flutter_watchlist_bloc/features/watchlist/screens/reorder_screen.dart';
import 'package:flutter_watchlist_bloc/features/watchlist/screens/watchlist_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: "watchlist",
        builder: (BuildContext context, GoRouterState state) {
          return const WatchlistScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/watchlist-reorder',
            name: "reorder",
            builder: (BuildContext context, GoRouterState state) {
              final title = state.extra;
              return ReorderWatchlistScreen(watchlistTitle: title.toString());
            },
          ),
        ],
      ),
    ],
  );
}
