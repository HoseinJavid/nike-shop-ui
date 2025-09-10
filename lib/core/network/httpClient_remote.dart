import 'package:dio/dio.dart';

final String emulatorUrl = 'http://10.0.2.2:8085/api/v1';
final String url = 'http://localhost:8085/api/v1';
final String phone = 'http://10.18.0.78:8085/api/v1';
final String phone2 = 'http://192.168.1.101:8085/api/v1';


late Dio httpClient;

void initDio() {
  httpClient = Dio(
    BaseOptions(
      baseUrl: phone2,
      connectTimeout: 5000,
      validateStatus: (status) => true,
    ),
  );
}
