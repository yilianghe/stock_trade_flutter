import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/env/app_config.dart';
import '../../core/network/dio_client.dart';
import '../../data/datasources/remote/api_client.dart';
import '../../data/repositories/market_repository_impl.dart';
import '../../data/repositories/signal_repository_impl.dart';
import '../../data/repositories/stock_repository_impl.dart';
import '../../data/repositories/strategy_repository_impl.dart';
import '../../data/repositories/system_repository_impl.dart';
import '../../data/repositories/watchlist_repository_impl.dart';
import '../../domain/entities/market_index_entity.dart';
import '../../domain/entities/market_overview_entity.dart';
import '../../domain/entities/signal_list_entity.dart';
import '../../domain/entities/strategy_entity.dart';
import '../../domain/repositories/market_repository.dart';
import '../../domain/repositories/signal_repository.dart';
import '../../domain/repositories/stock_repository.dart';
import '../../domain/repositories/strategy_repository.dart';
import '../../domain/repositories/system_repository.dart';
import '../../domain/repositories/watchlist_repository.dart';
import '../../domain/usecases/analyze_batch_usecase.dart';
import '../../domain/usecases/analyze_signal_usecase.dart';
import '../../domain/usecases/get_health_usecase.dart';
import '../../domain/usecases/get_market_index_usecase.dart';
import '../../domain/usecases/get_market_overview_usecase.dart';
import '../../domain/usecases/get_signal_history_usecase.dart';
import '../../domain/usecases/get_signal_list_usecase.dart';
import '../../domain/usecases/get_stock_info_usecase.dart';
import '../../domain/usecases/get_strategy_list_usecase.dart';
import '../../domain/usecases/get_watchlist_usecase.dart';
import '../../domain/usecases/search_stock_usecase.dart';

// ── 基础设施 ──

final appConfigProvider = Provider<AppConfig>((ref) {
  return const AppConfig(baseUrl: AppConstants.baseUrl);
});

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(ref.watch(appConfigProvider));
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.watch(dioClientProvider));
});

// ── Repository ──

final systemRepositoryProvider = Provider<SystemRepository>((ref) {
  return SystemRepositoryImpl(ref.watch(apiClientProvider));
});

final watchlistRepositoryProvider = Provider<WatchlistRepository>((ref) {
  return WatchlistRepositoryImpl(ref.watch(apiClientProvider));
});

final stockRepositoryProvider = Provider<StockRepository>((ref) {
  return StockRepositoryImpl(ref.watch(apiClientProvider));
});

final signalRepositoryProvider = Provider<SignalRepository>((ref) {
  return SignalRepositoryImpl(ref.watch(apiClientProvider));
});

final marketRepositoryProvider = Provider<MarketRepository>((ref) {
  return MarketRepositoryImpl(ref.watch(apiClientProvider));
});

final strategyRepositoryProvider = Provider<StrategyRepository>((ref) {
  return StrategyRepositoryImpl(ref.watch(apiClientProvider));
});

// ── UseCase ──

final getHealthUseCaseProvider = Provider<GetHealthUseCase>((ref) {
  return GetHealthUseCase(ref.watch(systemRepositoryProvider));
});

final getWatchlistUseCaseProvider = Provider<GetWatchlistUseCase>((ref) {
  return GetWatchlistUseCase(ref.watch(watchlistRepositoryProvider));
});

final getStockInfoUseCaseProvider = Provider<GetStockInfoUseCase>((ref) {
  return GetStockInfoUseCase(ref.watch(stockRepositoryProvider));
});

final searchStockUseCaseProvider = Provider<SearchStockUseCase>((ref) {
  return SearchStockUseCase(ref.watch(stockRepositoryProvider));
});

final analyzeSignalUseCaseProvider = Provider<AnalyzeSignalUseCase>((ref) {
  return AnalyzeSignalUseCase(ref.watch(signalRepositoryProvider));
});

final analyzeBatchUseCaseProvider = Provider<AnalyzeBatchUseCase>((ref) {
  return AnalyzeBatchUseCase(ref.watch(signalRepositoryProvider));
});

final getSignalHistoryUseCaseProvider = Provider<GetSignalHistoryUseCase>((ref) {
  return GetSignalHistoryUseCase(ref.watch(signalRepositoryProvider));
});

final getMarketOverviewUseCaseProvider = Provider<GetMarketOverviewUseCase>((ref) {
  return GetMarketOverviewUseCase(ref.watch(marketRepositoryProvider));
});

final getMarketIndexUseCaseProvider = Provider<GetMarketIndexUseCase>((ref) {
  return GetMarketIndexUseCase(ref.watch(marketRepositoryProvider));
});

final getSignalListUseCaseProvider = Provider<GetSignalListUseCase>((ref) {
  return GetSignalListUseCase(ref.watch(signalRepositoryProvider));
});

final getStrategyListUseCaseProvider = Provider<GetStrategyListUseCase>((ref) {
  return GetStrategyListUseCase(ref.watch(strategyRepositoryProvider));
});

// ── 数据状态 Provider（供页面直接使用）──

/// 市场概览数据
final marketOverviewProvider = FutureProvider<MarketOverviewEntity>((ref) {
  return ref.watch(getMarketOverviewUseCaseProvider).call();
});

/// 指数行情数据
final marketIndexProvider = FutureProvider<MarketIndexEntity>((ref) {
  return ref.watch(getMarketIndexUseCaseProvider).call();
});

/// 信号列表数据
final signalListProvider = FutureProvider.family<SignalListEntity, ({String? keyword, String? status})>(
  (ref, params) {
    return ref.watch(getSignalListUseCaseProvider).call(
          keyword: params.keyword,
          status: params.status,
        );
  },
);

/// 策略列表数据
final strategyListProvider = FutureProvider<List<StrategyEntity>>((ref) {
  return ref.watch(getStrategyListUseCaseProvider).call();
});
