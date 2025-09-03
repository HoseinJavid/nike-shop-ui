import 'package:dio/dio.dart';
import 'package:practice/core/network/validation.dart';
import 'package:practice/data/model/authInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IauthDataSource {
  Future<Authinfo> login(String username, String password);
  Future<Authinfo> signUp(String username, String password);
  Future<Authinfo> refreshToken(String refreshToken);
}

abstract class IauthLocalDataSource {
  Future<void> saveAuthInfo(Authinfo authinfo);
  Future<Authinfo?> getAuthInfo();
  Future<void> clearAuthInfo();
}

class AuthRemoteDataSourceImpl
    with HttpResponseValidation
    implements IauthDataSource {
  final Dio httpClient;

  AuthRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<Authinfo> login(String username, String password) async {
    //The user already has an account.
    var response = await httpClient.post(
      '/auth/token',
      data: {
        'username': username,
        'password': password,
        'grant_type': 'password',
      },
    );
    validateResposnse(response);
    return Authinfo(
      accessToken: response.data['access_token'],
      refreshToken: response.data['refresh_token'],
    );
  }

  @override
  Future<Authinfo> signUp(String username, String password) async {
    final response = await httpClient.post(
      '/user/register',
      data: {'email': username, 'password': password},
    );
    validateResposnse(response);
    return await login(username, password);
  }

  @override
  Future<Authinfo> refreshToken(String refreshToken) async {
    var response = await httpClient.post(
      '/auth/token',
      data: {'refresh_token': refreshToken, 'grant_type': 'refresh_token'},
    );
    validateResposnse(response);
    return Authinfo(
      accessToken: response.data['access_token'],
      refreshToken: response.data['refresh_token'],
    );
  }
}

class AuthLocalDataSourceImpl implements IauthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> clearAuthInfo() {
    return sharedPreferences.clear();
  }

  @override
  Future<Authinfo?> getAuthInfo() async {
    final accessToken = sharedPreferences.getString('access_token');
    final refreshToken = sharedPreferences.getString('refresh_token');
    if (accessToken != null && refreshToken != null) {
      return Authinfo(accessToken: accessToken, refreshToken: refreshToken);
    }
    return null;
  }

  @override
  Future<void> saveAuthInfo(Authinfo authInfo) async {
    sharedPreferences.setString('access_token', authInfo.accessToken);
    sharedPreferences.setString('refresh_token', authInfo.refreshToken);
  }
}
