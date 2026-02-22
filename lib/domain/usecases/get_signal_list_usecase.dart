import '../entities/signal_list_entity.dart';
import '../repositories/signal_repository.dart';

/// 获取信号列表用例
class GetSignalListUseCase {
  final SignalRepository _repository;

  GetSignalListUseCase(this._repository);

  Future<SignalListEntity> call({
    String? keyword,
    String? status,
    int limit = 20,
    int offset = 0,
  }) {
    return _repository.getSignals(
      keyword: keyword,
      status: status,
      limit: limit,
      offset: offset,
    );
  }
}
