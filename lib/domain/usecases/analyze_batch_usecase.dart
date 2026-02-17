import '../entities/signal_batch_item_entity.dart';
import '../repositories/signal_repository.dart';

class AnalyzeBatchUseCase {
  final SignalRepository repository;

  AnalyzeBatchUseCase(this.repository);

  Future<List<SignalBatchItemEntity>> call({
    required List<String> symbols,
    required String targetDate,
    required String strategyName,
  }) {
    return repository.analyzeBatch(
      symbols: symbols,
      targetDate: targetDate,
      strategyName: strategyName,
    );
  }
}
