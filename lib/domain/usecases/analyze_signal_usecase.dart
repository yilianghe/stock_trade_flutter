import '../entities/signal_result_entity.dart';
import '../repositories/signal_repository.dart';

class AnalyzeSignalUseCase {
  final SignalRepository repository;

  AnalyzeSignalUseCase(this.repository);

  Future<SignalResultEntity> call({
    required String symbol,
    required String targetDate,
    required String strategyName,
  }) {
    return repository.analyzeSignal(
      symbol: symbol,
      targetDate: targetDate,
      strategyName: strategyName,
    );
  }
}
