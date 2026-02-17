import '../entities/signal_history_item_entity.dart';
import '../repositories/signal_repository.dart';

class GetSignalHistoryUseCase {
  final SignalRepository repository;

  GetSignalHistoryUseCase(this.repository);

  Future<List<SignalHistoryItemEntity>> call({
    required String symbol,
    int limit = 30,
  }) {
    return repository.getHistory(symbol: symbol, limit: limit);
  }
}
