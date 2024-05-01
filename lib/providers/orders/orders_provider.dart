import 'package:flutter/material.dart';
import '../../data/models/orders/orders_response_model.dart';
import '../../data/models/response/app_response.dart';
import '../../data/repositories/orders/orders_repo.dart';
import '../../main.dart';
import '../../services/log/app_log.dart';
import '../../services/snacks/snacks.dart';

class OrdersProvider with ChangeNotifier {
  final OrdersRepository _ordersRepository;

  OrdersProvider({
    required OrdersRepository ordersRepository,
  }) : _ordersRepository = ordersRepository;

  final List<DeliveryBills> _allOrdersList = [];
  List<DeliveryBills> get getAllOrders => [..._allOrdersList];

  bool _isLoading = true;

  bool get getIsLoading => _isLoading;

  Future<void> fetch() async {
    _isLoading = true;
    notifyListeners();

    _allOrdersList.clear();

    AppResponse appResponse = await _ordersRepository.fetch();

    if (appResponse.hasError) {
      Snacks.showTopSnackBar(
        context: Get.context!,
        title: 'alert',
        body: appResponse.message!,
      );
    } else {
      final OrdersResponseModel orders =
          OrdersResponseModel.fromMap(appResponse.data!);
      MyLog.log(orders.toString());

      if (orders.result?.errNo != 0) {
        Snacks.showTopSnackBar(
          context: Get.context!,
          title: 'alert',
          body: orders.result!.errMsg!,
        );
      } else {
        _allOrdersList.addAll(orders.data?.deliveryBills ?? []);
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}
