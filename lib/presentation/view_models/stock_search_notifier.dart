import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/stock_search_item_entity.dart';
import '../../domain/usecases/search_stock_usecase.dart';
import '../state/providers.dart';

class StockSearchNotifier extends StateNotifier<AsyncValue<List<StockSearchItemEntity>>> {
  final SearchStockUseCase useCase;

  StockSearchNotifier(this.useCase) : super(const AsyncValue.data([]));

  Future<void> search(String keyword) async {
    if (keyword.trim().isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }
    state = const AsyncValue.loading();
    try {
      final result = await useCase.call(keyword);
      state = AsyncValue.data(result);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final stockSearchProvider =
    StateNotifierProvider<StockSearchNotifier, AsyncValue<List<StockSearchItemEntity>>>((ref) {
  return StockSearchNotifier(ref.watch(searchStockUseCaseProvider));
});
