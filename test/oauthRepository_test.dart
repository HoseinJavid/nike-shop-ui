import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practice/core/error/m_exeption.dart';
import 'package:practice/data/datasources/auth_data_source.dart';
import 'package:practice/data/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late IauthRepository authRepositoryImpl;
  late IauthLocalDataSource local;
  late IauthDataSource remote;
  late Dio httpClient;
  late SharedPreferences sharedPreferences;

  setUp(() async {
    httpClient = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:8085/api/v1',
        validateStatus: (status) => true,
      ),
    );

    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();

    remote = AuthRemoteDataSourceImpl(httpClient: httpClient);
    local = AuthLocalDataSourceImpl(sharedPreferences: sharedPreferences);
    authRepositoryImpl = AuthRepositoryImpl(remote: remote, local: local);
  });

  test(
    'register should succeed with valid credentials (integration test)',
    () async {
      // Arrange
      final email = 'test_${DateTime.now().millisecondsSinceEpoch}@example.com';
      final password = 'password123';
      final username = 'Integration User';

      // Act
      final result = await authRepositoryImpl.signUp(email, password);

      // Assert
      expect(result, isNotNull);
    },
  );

  test(
    'register should fail when email already exists (integration test)',
    () async {
      final email = 'duplicate@example.com';
      final password = 'password123';
      final username = 'Duplicate User';

      // Act + Assert
      expect(
        () async => await authRepositoryImpl.signUp(email, password),
        throwsA(isA<AppException>()),
      );
    },
  );
}
