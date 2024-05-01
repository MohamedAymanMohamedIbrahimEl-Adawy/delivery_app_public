import 'package:provider/provider.dart';

import 'auth/auth_provider.dart';
import 'order_details/order_details_provider.dart';
import 'order_status_types/order_status_types_provider.dart';
import 'orders/orders_provider.dart';
import '../serivce_locator.dart';

class AppProviders {
  final List<ChangeNotifierProvider> _providers = [
    ChangeNotifierProvider<OrderDetailsProvider>(
      create: (_) => serviceLocator<OrderDetailsProvider>(),
    ),
    ChangeNotifierProvider<OrdersProvider>(
      create: (_) => serviceLocator<OrdersProvider>(),
    ),
    ChangeNotifierProvider<AuthProvider>(
      create: (_) => serviceLocator<AuthProvider>(),
    ),
    ChangeNotifierProvider<OrderStatusTypesProvider>(
      create: (_) => serviceLocator<OrderStatusTypesProvider>(),
    )
  ];

  List<ChangeNotifierProvider> get getProviders {
    return [..._providers];
  }
}
