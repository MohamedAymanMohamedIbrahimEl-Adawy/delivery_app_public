import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/error/error_handler.dart';
import '../../../services/network/dio_client.dart';
import '../../constants/constants.dart';
import '../../models/response/app_response.dart';

abstract class OrderStatusTypesRepository {
  final ErrorHandler errorHandler;
  final SharedPreferences sharedPreferences;
  OrderStatusTypesRepository({
    required this.errorHandler,
    required this.sharedPreferences,
  });
  Future<AppResponse> fetch();
  Future<AppResponse> clearAll();
  Future<AppResponse> add();
  Future<AppResponse> delete();
}

class ServerOrderStatusTypesRepo extends OrderStatusTypesRepository {
  final DioClient dioClient;

  ServerOrderStatusTypesRepo({
    required this.dioClient,
    required super.errorHandler,
    required super.sharedPreferences,
  });

  @override
  Future<AppResponse> add() async {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<AppResponse> clearAll() async {
    // TODO: implement clearAll
    throw UnimplementedError();
  }

  @override
  Future<AppResponse> delete() async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<AppResponse> fetch() async {
    late final Response response;
    try {
      response = await dioClient.post(
        Constants.orderStatusTypes,
        data: {
          "Value": {
            "P_LANG_NO":
                sharedPreferences.getString(Constants.langaugeNumberKey) ?? '2',
          }
        },
      );
      return AppResponse.withSuccess(
        data: response.data,
      );
    } catch (e) {
      return AppResponse.withError(
        message: errorHandler.getErrorMessage(e),
        data: response.data,
      );
    }
  }
}
