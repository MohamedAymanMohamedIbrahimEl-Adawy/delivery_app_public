import 'package:dio/dio.dart';

import '../../../services/error/error_handler.dart';
import '../../../services/network/dio_client.dart';
import '../../constants/constants.dart';
import '../../models/response/app_response.dart';

abstract class OrderDetailsRepository {
  final ErrorHandler errorHandler;

  OrderDetailsRepository({
    required this.errorHandler,
  });

  Future<AppResponse> getByID(int id);
  Future<AppResponse> getReviews(int id);
  Future<AppResponse> getViews(int id);
}

class ServerOrderDetailsRepo extends OrderDetailsRepository {
  final DioClient dioClient;

  ServerOrderDetailsRepo({
    required this.dioClient,
    required super.errorHandler,
  });

  @override
  Future<AppResponse> getByID(int id) async {
    late final Response response;
    try {
      response = await dioClient.get(
        Constants.orderById(id),
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

  @override
  Future<AppResponse> getReviews(int id) async {
    // TODO: implement getReviews
    throw UnimplementedError();
  }

  @override
  Future<AppResponse> getViews(int id) async {
    // TODO: implement getViews
    throw UnimplementedError();
  }
}
