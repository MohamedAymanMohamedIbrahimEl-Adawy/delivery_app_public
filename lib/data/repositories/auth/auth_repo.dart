import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/error/error_handler.dart';
import '../../../services/network/dio_client.dart';
import '../../constants/constants.dart';
import '../../models/login/login_request_model.dart';
import '../../models/response/app_response.dart';

abstract class AuthRepository {
  final ErrorHandler errorHandler;
  final SharedPreferences sharedPreferences;

  AuthRepository({
    required this.errorHandler,
    required this.sharedPreferences,
  });
  Future<AppResponse> login(LoginRequestModel loginRequestModel);
  Future<AppResponse> logout();
  Future<AppResponse> register();
  Future<AppResponse> deleteAccount();
  Future<void> setLoginStatus(bool status);
  bool getLoginStatus();
  Future<void> setName(String name);
  Future<void> setUserId(String userId);
  String getName();
  String getUserId();
}

class ServerAuthRepo extends AuthRepository {
  final DioClient _dioClient;

  ServerAuthRepo(
      {required DioClient dioClient,
      required super.errorHandler,
      required super.sharedPreferences})
      : _dioClient = dioClient;

  @override
  Future<AppResponse> deleteAccount() async {
    try {
      return AppResponse.withSuccess();
    } catch (e) {
      return AppResponse.withError();
    }
  }

  @override
  Future<AppResponse> login(LoginRequestModel loginRequestModel) async {
    late final Response response;
    try {
      loginRequestModel.value?.pLANGNO =
          sharedPreferences.getString(Constants.langaugeNumberKey) ?? '2';

      response = await _dioClient.post(
        Constants.loginApi,
        data: loginRequestModel.toMap(),
      );

      return AppResponse.withSuccess(
        data: response.data,
      );
    } catch (e) {
      return AppResponse.withError(
        message: errorHandler.getErrorMessage(e),
      );
    }
  }

  @override
  Future<AppResponse> logout() async {
    try {
      return AppResponse.withSuccess();
    } catch (e) {
      return AppResponse.withError();
    }
  }

  @override
  Future<AppResponse> register() async {
    try {
      return AppResponse.withSuccess();
    } catch (e) {
      return AppResponse.withError();
    }
  }

  @override
  bool getLoginStatus() {
    return sharedPreferences.getBool(Constants.isLoggedInKey) ?? false;
  }

  @override
  Future<void> setLoginStatus(bool status) async {
    await sharedPreferences.setBool(Constants.isLoggedInKey, status);
  }

  @override
  Future<void> setName(String name) async {
    await sharedPreferences.setString(Constants.userNameKey, name);
  }

  @override
  Future<void> setUserId(String userId) async {
    await sharedPreferences.setString(Constants.userIdKey, userId);
  }

  @override
  String getName() {
    return sharedPreferences.getString(Constants.userNameKey) ?? '';
  }

  @override
  String getUserId() {
    return sharedPreferences.getString(Constants.userIdKey) ?? '';
  }
}
