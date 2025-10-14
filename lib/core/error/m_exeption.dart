class AppException implements Exception {
  final String message;
  AppException([this.message = "unkhown error"]);
}

class UserAlreadyExistsException extends AppException {
  UserAlreadyExistsException([super.message = "this email alreay exist"]);
}

class NetworkException extends AppException {
  NetworkException([super.message = "network error"]);
}

class ServerException extends AppException {
  ServerException([super.message = "server error"]);
}

class ValidationException extends AppException {
  final Map<String, dynamic>? errors;
  ValidationException({message = "validation error", this.errors})
    : super(message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([super.message = "Unauthorized user"]);
}

class NotFoundException extends AppException {
  NotFoundException([super.message = "not found"]);
}

class EmptyCartException extends AppException {
  EmptyCartException([super.message = "cart is empty"]);
}

abstract class AppError {
  String get message;
}
