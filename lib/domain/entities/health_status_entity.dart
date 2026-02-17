class HealthStatusEntity {
  final String status;
  final String app;
  final String? disclaimer;

  HealthStatusEntity({
    required this.status,
    required this.app,
    this.disclaimer,
  });
}
