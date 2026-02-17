import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/env/app_config.dart';
import '../../core/network/dio_client.dart';
import '../../data/datasources/remote/api_client.dart';
import '../../data/repositories/signal_repository_impl.dart';
import '../../data/repositories/stock_repository_impl.dart';
import '../../data/repositories/system_repository_impl.dart';
import '../../data/repositories/watchlist_repository_impl.dart';
import '../../domain/repositories/signal_repository.dart';
import '../../domain/repositories/stock_repository.dart';
import '../../domain/repositories/system_repository.dart';
import '../../domain/repositories/watchlist_repository.dart';
import '../../domain/usecases/analyze_batch_usecase.dart';
import '../../domain/usecases/analyze_signal_usecase.dart';
import '../../domain/usecases/get_health_usecase.dart';
import '../../domain/usecases/get_signal_history_usecase.dart';
import '../../domain/usecases/get_stock_info_usecase.dart';
import '../../domain/usecases/get_watchlist_usecase.dart';
import '../../domain/usecases/search_stock_usecase.dart';

final appConfigProvider = Provider<AppConfig>((ref) {
  return const AppConfig(baseUrl: AppConstants.baseUrl);
});

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(ref.watch(appConfigProvider));
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.watch(dioClientProvider));
});

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
