import 'package:practice/data/datasources/auth_data_source.dart';
import 'package:practice/data/model/authInfo.dart';

abstract class IauthRepository extends IauthDataSource {
  Future<void> signOut();
}

class AuthRepositoryImpl extends IauthRepository {
  final IauthDataSource remote;
  final IauthLocalDataSource local;

  AuthRepositoryImpl({required this.remote, required this.local});

  @override
  Future<Authinfo> login(String username, String password) async {
    var authInfo = await remote.login(username, password);
    await local.saveAuthInfo(authInfo);
    return authInfo;
  }

  @override
  Future<Authinfo> refreshToken(String refreshToken) async {
    var authInfo = await remote.refreshToken(refreshToken);
    local.saveAuthInfo(authInfo);
    return authInfo;
  }

  @override
  Future<void> signOut() {
    return local.clearAuthInfo();
  }

  @override
  Future<Authinfo> signUp(
    String username,
    String password,
  ) async {
    var authInfo = await remote.signUp(username, password);
    local.saveAuthInfo(authInfo);
    return authInfo;
  }
}
