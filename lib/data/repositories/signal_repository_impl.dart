import '../../domain/entities/signal_batch_item_entity.dart';
import '../../domain/entities/signal_history_item_entity.dart';
import '../../domain/entities/signal_list_entity.dart';
import '../../domain/entities/signal_result_entity.dart';
import '../../domain/repositories/signal_repository.dart';
import '../datasources/remote/api_client.dart';
import '../models/signal_request.dart';

class SignalRepositoryImpl implements SignalRepository {
  final ApiClient apiClient;

  SignalRepositoryImpl(this.apiClient);

  @override
  Future<SignalResultEntity> analyzeSignal({
    required String symbol,
    required String targetDate,
    required String strategyName,
  }) async {
    final result = await apiClient.analyzeSignal(
      SignalRequest(
        symbol: symbol,
        targetDate: targetDate,
        strategyName: strategyName,
      ),
    );
    return SignalResultEntity(
      symbol: result.symbol,
      mode: result.mode,
      targetDate: result.targetDate,
      signalStatus: result.signalStatus,
      passedRules: result.passedRules,
      failedRules: result.failedRules,
      ruleDetails: result.ruleDetails,
      explanation: result.explanation,
      strategyName: result.strategyName,
      executedAt: result.executedAt,
      disclaimer: result.disclaimer,
    );
  }

  @override
  Future<List<SignalBatchItemEntity>> analyzeBatch({
    required List<String> symbols,
    required String targetDate,
    required String strategyName,
  }) async {
    final result = await apiClient.analyzeBatch(
      SignalRequest(
        symbol: symbols.first,
        targetDate: targetDate,
        strategyName: strategyName,
      ),
      symbols,
    );
    return result
        .map(
          (item) => SignalBatchItemEntity(
            symbol: item.symbol,
            mode: item.mode,
            targetDate: item.targetDate,
            signalStatus: item.signalStatus,
            passedRules: item.passedRules,
            failedRules: item.failedRules,
            ruleDetails: item.ruleDetails,
            explanation: item.explanation,
            strategyName: item.strategyName,
            executedAt: item.executedAt,
            disclaimer: item.disclaimer,
            error: item.error,
          ),
        )
        .toList();
  }

  @override
  Future<List<SignalHistoryItemEntity>> getHistory({
    required String symbol,
    int limit = 30,
  }) async {
    final result = await apiClient.getSignalHistory(symbol, limit: limit);
    return result
        .map(
          (item) => SignalHistoryItemEntity(
            symbol: item.symbol,
            targetDate: item.targetDate,
            signalStatus: item.signalStatus,
            strategyName: item.strategyName,
            explanation: item.explanation,
            executedAt: item.executedAt,
          ),
        )
        .toList();
  }

  @override
  Future<SignalListEntity> getSignals({
    String? keyword,
    String? status,
    int limit = 20,
    int offset = 0,
  }) async {
    final result = await apiClient.getSignals(
      keyword: keyword,
      status: status,
      limit: limit,
      offset: offset,
    );
    return SignalListEntity(
      total: result.total,
      items: result.items
          .map((item) => SignalListItemEntity(
                id: item.id,
                symbol: item.symbol,
                name: item.name,
                price: item.price,
                change: item.change,
                timestamp: item.timestamp,
                status: item.status,
                rules: item.rules
                    .map((r) => SignalRuleEntity(
                          name: r.name,
                          description: r.description,
                          satisfied: r.satisfied,
                          value: r.value,
                          threshold: r.threshold,
                        ))
                    .toList(),
              ))
          .toList(),
    );
  }
}
