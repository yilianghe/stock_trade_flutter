import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/signal_history_item_entity.dart';
import '../../domain/usecases/get_signal_history_usecase.dart';
import '../state/providers.dart';

class SignalHistoryNotifier extends StateNotifier<AsyncValue<List<SignalHistoryItemEntity>>> {
  final GetSignalHistoryUseCase useCase;

  SignalHistoryNotifier(this.useCase) : super(const AsyncValue.data([]));

  Future<void> load(String symbol, {int limit = 30}) async {
    state = const AsyncValue.loading();
    try {
      final result = await useCase.call(symbol: symbol, limit: limit);
      state = AsyncValue.data(result);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final signalHistoryProvider =
    StateNotifierProvider<SignalHistoryNotifier, AsyncValue<List<SignalHistoryItemEntity>>>((ref) {
  return SignalHistoryNotifier(ref.watch(getSignalHistoryUseCaseProvider));
});
