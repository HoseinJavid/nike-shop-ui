import 'package:dio/dio.dart';
import 'package:practice/core/local/sharedPreferences_local.dart';
import 'package:practice/data/repository/auth_repository.dart';
import 'package:practice/di/service_locator.dart';

final String emulatorUrl = 'http://10.0.2.2:8085/api/v1';
final String url = 'http://localhost:8085/api/v1';
final String phone = 'http://192.168.43.156:8085/api/v1';

late Dio _httpClient;
// late Dio _httpClientSandboxZarinPal;

Dio initDio() {
  _httpClient = Dio(
    BaseOptions(
      // baseUrl: emulatorUrl,
      baseUrl: phone,
      connectTimeout: 7000,
      receiveTimeout: 7000,
      validateStatus: (status) => true,
    ),
  );

  _httpClient.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        var auth = getIt<AuthRepositoryImpl>();
        var authInfo = await auth.getAuthInfo();
        if (authInfo != null) {
          options.headers['Authorization'] = 'Bearer ${authInfo.accessToken}';
        }
        return handler.next(options);
      },
    ),
  );

  return _httpClient;
}

// Dio initDioSandboxZarinPal() {
//   _httpClientSandboxZarinPal = Dio(
//     BaseOptions(
//       baseUrl: 'https://sandbox.zarinpal.com/pg/v4',
//       connectTimeout: 5000,
//       receiveTimeout: 3000,
//       validateStatus: (status) => true,
//     ),
//   );

//   return _httpClientSandboxZarinPal;
// }
