import 'package:dio/dio.dart';
import '../env/app_config.dart';

class DioClient {
  final Dio dio;

  DioClient(AppConfig config)
      : dio = Dio(
          BaseOptions(
            baseUrl: config.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 15),
          ),
        );
}
