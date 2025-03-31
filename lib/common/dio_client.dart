import 'package:dio/dio.dart';
import 'package:nike_ecommerce/common/app_constants.dart';

class DioClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrlEmulator,
    connectTimeout: const Duration(seconds: 5),
  ));

  static Dio get dio => _dio;
}
