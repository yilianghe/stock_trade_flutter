import '../entities/signal_batch_item_entity.dart';
import '../entities/signal_history_item_entity.dart';
import '../entities/signal_result_entity.dart';

abstract class SignalRepository {
  Future<SignalResultEntity> analyzeSignal({
    required String symbol,
    required String targetDate,
    required String strategyName,
  });
  Future<List<SignalBatchItemEntity>> analyzeBatch({
    required List<String> symbols,
    required String targetDate,
    required String strategyName,
  });
  Future<List<SignalHistoryItemEntity>> getHistory({
    required String symbol,
    int limit,
  });
}
