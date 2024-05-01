import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../data/models/response/error_response.dart';

abstract class ErrorHandler {
  String getErrorMessage(dynamic error);
}

class LocalErrorHandler extends ErrorHandler {
  @override
  String getErrorMessage(error) {
    // TODO: implement getMessage
    throw UnimplementedError();
  }
}

class ApiErrorHandler extends ErrorHandler {
  @override
  String getErrorMessage(error) {
    String errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              errorDescription = "Request to API server was cancelled";
              break;
            case DioExceptionType.connectionTimeout:
              errorDescription = "Connection timeout with API server";
              break;
            case DioExceptionType.unknown:
              errorDescription =
                  "Connection to API server failed due to internet connection";
              break;
            case DioExceptionType.receiveTimeout:
              errorDescription =
                  "Receive timeout in connection with API server";
              break;
            case DioExceptionType.badResponse:
              switch (error.response!.statusCode) {
                case 400:
                  debugPrint(
                      '<==Here is error body==${error.response!.data.toString()}===>');
                  errorDescription = 'Error 400';
                  break;
                case 401:
                  debugPrint(
                      '<==Here is error body==${error.response!.data.toString()}===>');
                  errorDescription = 'Error 401';
                  break;
                case 403:
                  debugPrint(
                      '<==Here is error body==${error.response!.data.toString()}===>');
                  if (error.response!.data['errors'] != null) {
                    errorDescription = error.response!.data['errors'][0];
                  } else {
                    errorDescription = error.response!.data['message'];
                  }
                  break;
                case 404:
                case 500:
                case 503:
                case 429:
                  errorDescription = error.response!.statusMessage!;
                  break;
                default:
                  ErrorResponse errorResponse =
                      ErrorResponse.fromJson(error.response!.data);
                  if (errorResponse.errors != null &&
                      errorResponse.errors!.isNotEmpty) {
                    errorDescription = errorResponse.errors![0].message ?? '';
                  } else {
                    errorDescription =
                        "Failed to load data - status code: ${error.response!.statusCode}";
                  }
              }
              break;
            case DioExceptionType.sendTimeout:
              errorDescription = "Send timeout with server";
              break;
            default:
              errorDescription = 'Default Dio exception error';
              break;
          }
        } else {
          errorDescription = "Unexpected error occured";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "is not a subtype of exception";
    }
    return errorDescription;
  }
}
