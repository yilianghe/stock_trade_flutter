import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/signal_page.dart';
import '../pages/stock_search_page.dart';
import '../pages/watchlist_page.dart';

class AppRouter {
  static const String home = '/';
  static const String watchlist = '/watchlist';
  static const String signal = '/signal';
  static const String stockSearch = '/stock-search';

  static final Map<String, WidgetBuilder> routes = {
    home: (_) => const HomePage(),
    watchlist: (_) => const WatchlistPage(),
    signal: (_) => const SignalPage(),
    stockSearch: (_) => const StockSearchPage(),
  };
}
