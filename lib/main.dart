import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_watchlist_bloc/core/route.dart';
import 'package:flutter_watchlist_bloc/core/theme.dart';
import 'package:flutter_watchlist_bloc/features/watchlist/bloc/watchlist_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appRoutes = AppRoutes();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [BlocProvider(create: (context) => WatchlistBloc())],
          child: MaterialApp.router(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            routerConfig: appRoutes.router,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
