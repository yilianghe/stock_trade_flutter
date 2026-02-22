import 'package:dio/dio.dart';
import '../../../core/error/app_exception.dart';
import '../../../core/network/api_paths.dart';
import '../../../core/network/dio_client.dart';
import '../../models/api_response.dart';
import '../../models/health_status.dart';
import '../../models/market_index.dart';
import '../../models/market_overview.dart';
import '../../models/signal_batch_item.dart';
import '../../models/signal_history_item.dart';
import '../../models/signal_list_response.dart';
import '../../models/signal_request.dart';
import '../../models/signal_result.dart';
import '../../models/stock_info.dart';
import '../../models/stock_search_item.dart';
import '../../models/stock_sync_result.dart';
import '../../models/strategy_list_response.dart';
import '../../models/watchlist_delete_result.dart';
import '../../models/watchlist_item.dart';
import '../../models/watchlist_list.dart';
import '../../models/watchlist_symbols.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(DioClient client) : _dio = client.dio;

  Future<HealthStatus> getHealth() async {
    final response = await _dio.get(ApiPaths.health);
    return _parseResponse(response, (data) => HealthStatus.fromJson(data as Map<String, dynamic>));
  }

  Future<WatchlistList> getWatchlist() async {
    final response = await _dio.get(ApiPaths.watchlist);
    return _parseResponse(response, (data) => WatchlistList.fromJson(data as Map<String, dynamic>));
  }

  Future<WatchlistSymbols> getWatchlistSymbols() async {
    final response = await _dio.get(ApiPaths.watchlistSymbols);
    return _parseResponse(response, (data) => WatchlistSymbols.fromJson(data as Map<String, dynamic>));
  }

  Future<WatchlistItem> getWatchlistItem(String symbol) async {
    final response = await _dio.get('${ApiPaths.watchlist}/$symbol');
    return _parseResponse(response, (data) => WatchlistItem.fromJson(data as Map<String, dynamic>));
  }

  Future<WatchlistItem> addWatchlistItem({
    required String symbol,
    required List<String> tags,
    String? note,
  }) async {
    final response = await _dio.post(
      ApiPaths.watchlist,
      data: {
        'symbol': symbol,
        'tags': tags,
        'note': note,
      },
    );
    return _parseResponse(response, (data) => WatchlistItem.fromJson(data as Map<String, dynamic>));
  }

  Future<WatchlistItem> updateWatchlistItem({
    required String symbol,
    required List<String> tags,
    String? note,
  }) async {
    final response = await _dio.put(
      '${ApiPaths.watchlist}/$symbol',
      data: {
        'tags': tags,
        'note': note,
      },
    );
    return _parseResponse(response, (data) => WatchlistItem.fromJson(data as Map<String, dynamic>));
  }

  Future<WatchlistDeleteResult> deleteWatchlistItem(String symbol) async {
    final response = await _dio.delete('${ApiPaths.watchlist}/$symbol');
    return _parseResponse(
      response,
      (data) => WatchlistDeleteResult.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<StockInfo> getStockInfo(String symbol) async {
    final response = await _dio.get('${ApiPaths.stock}/$symbol');
    return _parseResponse(response, (data) => StockInfo.fromJson(data as Map<String, dynamic>));
  }

  Future<List<StockSearchItem>> searchStock(String keyword) async {
    final response = await _dio.get('${ApiPaths.stockSearch}/$keyword');
    return _parseResponse(
      response,
      (data) => (data as List<dynamic>)
          .map((e) => StockSearchItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<StockSyncResult> syncStock() async {
    final response = await _dio.post(ApiPaths.stockSync);
    return _parseResponse(response, (data) => StockSyncResult.fromJson(data as Map<String, dynamic>));
  }

  Future<SignalResult> analyzeSignal(SignalRequest request) async {
    final response = await _dio.post(ApiPaths.signalAnalyze, data: request.toJson());
    return _parseResponse(response, (data) => SignalResult.fromJson(data as Map<String, dynamic>));
  }

  Future<List<SignalBatchItem>> analyzeBatch(SignalRequest request, List<String> symbols) async {
    final response = await _dio.post(
      ApiPaths.signalBatchAnalyze,
      data: {
        'symbols': symbols,
        'target_date': request.targetDate,
        'strategy_name': request.strategyName,
      },
    );
    return _parseResponse(
      response,
      (data) => (data as List<dynamic>)
          .map((e) => SignalBatchItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<List<SignalHistoryItem>> getSignalHistory(String symbol, {int limit = 30}) async {
    final response = await _dio.get(
      '${ApiPaths.signalHistory}/$symbol',
      queryParameters: {'limit': limit},
    );
    return _parseResponse(
      response,
      (data) => (data as List<dynamic>)
          .map((e) => SignalHistoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // ── 市场概览 ──

  Future<MarketOverview> getMarketOverview() async {
    final response = await _dio.get(ApiPaths.marketOverview);
    return _parseResponse(
      response,
      (data) => MarketOverview.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<MarketIndex> getMarketIndex({
    String indexCode = '000001.SH',
    String period = '1w',
  }) async {
    final response = await _dio.get(
      ApiPaths.marketIndex,
      queryParameters: {'index_code': indexCode, 'period': period},
    );
    return _parseResponse(
      response,
      (data) => MarketIndex.fromJson(data as Map<String, dynamic>),
    );
  }

  // ── 信号列表 ──

  Future<SignalListResponse> getSignals({
    String? keyword,
    String? status,
    int limit = 20,
    int offset = 0,
  }) async {
    final params = <String, dynamic>{'limit': limit, 'offset': offset};
    if (keyword != null && keyword.isNotEmpty) params['keyword'] = keyword;
    if (status != null && status.isNotEmpty) params['status'] = status;

    final response = await _dio.get(
      ApiPaths.signals,
      queryParameters: params,
    );
    return _parseResponse(
      response,
      (data) => SignalListResponse.fromJson(data as Map<String, dynamic>),
    );
  }

  // ── 策略列表 ──

  Future<StrategyListResponse> getStrategies() async {
    final response = await _dio.get(ApiPaths.strategies);
    return _parseResponse(
      response,
      (data) => StrategyListResponse.fromJson(data as Map<String, dynamic>),
    );
  }

  T _parseResponse<T>(Response response, T Function(dynamic) parser) {
    if (response.data is Map<String, dynamic>) {
      return ApiResponse<T>.fromJson(response.data as Map<String, dynamic>, parser).data;
    }
    throw const AppException('响应结构异常');
  }
}
