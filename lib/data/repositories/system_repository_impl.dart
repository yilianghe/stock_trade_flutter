import '../../domain/entities/health_status_entity.dart';
import '../../domain/repositories/system_repository.dart';
import '../datasources/remote/api_client.dart';

class SystemRepositoryImpl implements SystemRepository {
  final ApiClient apiClient;

  SystemRepositoryImpl(this.apiClient);

  @override
  Future<HealthStatusEntity> getHealth() async {
    final result = await apiClient.getHealth();
    return HealthStatusEntity(
      status: result.status,
      app: result.app,
      disclaimer: result.disclaimer,
    );
  }
}
