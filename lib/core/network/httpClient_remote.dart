import 'package:dio/dio.dart';

final String emulatorUrl = 'http://10.0.2.2:8085/api/v1';
final String url = 'http://localhost:8085/api/v1';
late Dio httpClient;

void initDio() {
  httpClient = Dio(
    BaseOptions(
      baseUrl: emulatorUrl,
      connectTimeout: 5000,
      validateStatus: (status) => true,
    ),
  );
}
