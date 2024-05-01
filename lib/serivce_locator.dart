import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/constants/constants.dart';
import 'data/repositories/auth/auth_repo.dart';
import 'data/repositories/order_details/order_details_repo.dart';
import 'data/repositories/order_status_types/order_status_types_repo.dart';
import 'data/repositories/orders/orders_repo.dart';
import 'providers/auth/auth_provider.dart';
import 'providers/order_details/order_details_provider.dart';
import 'providers/order_status_types/order_status_types_provider.dart';
import 'providers/orders/orders_provider.dart';
import 'services/error/error_handler.dart';
import 'services/network/dio_client.dart';
import 'services/network/logging_interceptor.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initServices() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  // Shared Prefs
  serviceLocator.registerLazySingleton<SharedPreferences>(() => pref);

  // Register connectivity
  serviceLocator.registerLazySingleton(() => Connectivity());

  // Registering Dio
  serviceLocator.registerLazySingleton(() => Dio());
  serviceLocator.registerLazySingleton(() => LoggingInterceptor());
  serviceLocator.registerLazySingleton(() => DioClient(
        Constants.baseUrl,
        serviceLocator<Dio>(),
        loggingInterceptor: serviceLocator<LoggingInterceptor>(),
        sharedPreferences: serviceLocator<SharedPreferences>(),
      ));

  // Registering error handler
  serviceLocator.registerLazySingleton<ErrorHandler>(() => ApiErrorHandler());

  // Registering Repos
  serviceLocator.registerLazySingleton<OrdersRepository>(
    () => ServerOrdersRepo(
      dioClient: serviceLocator<DioClient>(),
      errorHandler: serviceLocator<ErrorHandler>(),
      sharedPreferences: serviceLocator<SharedPreferences>(),
    ),
  );
  serviceLocator.registerLazySingleton<OrderDetailsRepository>(
    () => ServerOrderDetailsRepo(
      dioClient: serviceLocator<DioClient>(),
      errorHandler: serviceLocator<ErrorHandler>(),
    ),
  );
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => ServerAuthRepo(
      dioClient: serviceLocator<DioClient>(),
      errorHandler: serviceLocator<ErrorHandler>(),
      sharedPreferences: serviceLocator<SharedPreferences>(),
    ),
  );
  serviceLocator.registerLazySingleton<OrderStatusTypesRepository>(
    () => ServerOrderStatusTypesRepo(
      dioClient: serviceLocator<DioClient>(),
      errorHandler: serviceLocator<ErrorHandler>(),
      sharedPreferences: serviceLocator<SharedPreferences>(),
    ),
  );
  //  serviceLocator.registerLazySingleton<MovieDetailsRepository>(
  //   () => LocalMovieDetailsRepo(
  //     // dbClient: serviceLocator<SQFLITE>(),
  //     errorHandler: serviceLocator<ErrorHandler>(),
  //   ),
  // );

  // Registering providers
  serviceLocator.registerFactory<OrdersProvider>(
    () => OrdersProvider(
      ordersRepository: serviceLocator<OrdersRepository>(),
    ),
  );
  serviceLocator.registerFactory<OrderDetailsProvider>(
    () => OrderDetailsProvider(
      orderDetailsRepository: serviceLocator<OrderDetailsRepository>(),
    ),
  );
  serviceLocator.registerFactory<AuthProvider>(
    () => AuthProvider(
      authRepository: serviceLocator<AuthRepository>(),
    ),
  );
  serviceLocator.registerFactory<OrderStatusTypesProvider>(
    () => OrderStatusTypesProvider(
      orderStatusTypesRepository: serviceLocator<OrderStatusTypesRepository>(),
    ),
  );
}
