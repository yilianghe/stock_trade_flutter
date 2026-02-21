import 'package:flutter/material.dart';
import '../pages/main_shell.dart';
import '../pages/stock_search_page.dart';
import '../pages/stock_detail_page.dart';
import '../pages/add_watchlist_page.dart';

/// 应用路由配置
/// 主入口改为 MainShell（底部导航框架），保留旧页面路由兼容
class AppRouter {
  static const String home = '/';
  static const String stockSearch = '/stock-search';
  static const String stockDetail = '/stock-detail';
  static const String addWatchlist = '/add-watchlist';

  static final Map<String, WidgetBuilder> routes = {
    home: (_) => const MainShell(),
    stockSearch: (_) => const StockSearchPage(),
    stockDetail: (_) => const StockDetailPage(),
    addWatchlist: (_) => const AddWatchlistPage(),
  };
}
