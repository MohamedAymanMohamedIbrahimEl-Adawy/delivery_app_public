import 'package:deliveryapp/data/models/orders/orders_request_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/error/error_handler.dart';
import '../../../services/network/dio_client.dart';
import '../../constants/constants.dart';
import '../../models/response/app_response.dart';

abstract class OrdersRepository {
  final ErrorHandler errorHandler;
  final SharedPreferences sharedPreferences;
  OrdersRepository({
    required this.errorHandler,
    required this.sharedPreferences,
  });
  Future<AppResponse> fetch();
  Future<AppResponse> clearAll();
  Future<AppResponse> add();
  Future<AppResponse> delete();
}

class ServerOrdersRepo extends OrdersRepository {
  final DioClient dioClient;

  ServerOrdersRepo({
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
      final OrdersRequestModel ordersRequestModel = OrdersRequestModel(
        value: Value(
          pBILLSRL: "",
          pLANGNO:
              sharedPreferences.getString(Constants.langaugeNumberKey) ?? '2',
          pPRCSSDFLG: "",
          pDLVRYNO: sharedPreferences.getString(Constants.userIdKey),
        ),
      );

      response = await dioClient.post(
        Constants.orders,
        data: ordersRequestModel.toMap(),
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
