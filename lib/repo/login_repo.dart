import 'package:afisha_admin_panel/db/login_db.dart';
import 'package:afisha_admin_panel/network/network_info.dart';
import 'package:afisha_admin_panel/utils/failure.dart';
import 'package:afisha_admin_panel/utils/success.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

class LoginRepo {
  late Dio dio;
  NetworkInfo networkInfo;

  LoginRepo({required this.dio, required this.networkInfo});

  Future<Either<BaseFailure, Success>> confirmUser(
      String password, String login) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dio.post('/api/mobile/login',
            data: {'password': password, 'login': login.replaceAll(' ', '')});
        if (res.data != null) {
          final token = res.data['token'];
          LoginDb.setToken(token);
          return Right(Success());
        }
        return Left(Failure());
      } catch (e) {
        return Left(Failure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
