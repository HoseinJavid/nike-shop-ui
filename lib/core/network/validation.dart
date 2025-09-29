import 'package:dio/dio.dart';
import 'package:practice/core/error/m_exeption.dart';

mixin HttpResponseValidation {
  validateResposnse(Response response) {
    if (response.statusCode == null) {
      throw NetworkException();
    }
    if (response.statusCode == 409) {
      throw UserAlreadyExistsException();
    } else if (response.statusCode == 500) {
      throw ServerException();
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else if (response.statusCode != 200) {
      throw AppException();
    }
  }
}
