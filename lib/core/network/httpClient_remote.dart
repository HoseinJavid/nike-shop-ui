import 'package:dio/dio.dart';

final String emulatorUrl = 'http://10.0.2.2:8085/api/v1';
final String url = 'http://localhost:8085/api/v1';
Dio httpClient = Dio(BaseOptions(baseUrl: emulatorUrl));
