import 'package:deliveryapp/services/theme/app_theme.dart';
import 'package:flutter/material.dart';
import '../../data/models/orders/order_status_types_response_model.dart';
import '../../data/models/response/app_response.dart';
import '../../data/repositories/order_status_types/order_status_types_repo.dart';
import '../../main.dart';
import '../../services/snacks/snacks.dart';

class OrderStatusTypesProvider with ChangeNotifier {
  final OrderStatusTypesRepository _orderStatusTypesRepository;

  OrderStatusTypesProvider({
    required OrderStatusTypesRepository orderStatusTypesRepository,
  }) : _orderStatusTypesRepository = orderStatusTypesRepository;

  final List<DeliveryStatusTypes> _orderStatusTpes = [];
  List<DeliveryStatusTypes> get getOrderStatusTypes => [..._orderStatusTpes];

  DeliveryStatusTypes getOrderStatusType(String typeNumber) {
    return _orderStatusTpes
        .firstWhere((element) => element.tYPNO == typeNumber);
  }

  // bool _isLoading = false;

  // bool get getIsLoading => _isLoading;

  Future<void> fetch() async {
    final AppResponse appResponse = await _orderStatusTypesRepository.fetch();
    if (appResponse.hasError) {
      Snacks.showTopSnackBar(
        context: Get.context!,
        title: 'alert',
        body: appResponse.message!,
      );
    } else {
      OrderStatusTypesResponse orderStatusTypesResponse =
          OrderStatusTypesResponse.fromMap(appResponse.data!);
      if (orderStatusTypesResponse.result?.errNo != 0) {
        Snacks.showTopSnackBar(
          context: Get.context!,
          title: 'alert',
          body: orderStatusTypesResponse.result!.errMsg!,
        );
      } else {
        _orderStatusTpes
            .addAll(orderStatusTypesResponse.data?.deliveryStatusTypes ?? []);
        _orderStatusTpes.addAll(
          [
            DeliveryStatusTypes(
              tYPNM: 'New',
              tYPNO: '0',
              color: AppColors.greenColor,
            ),
            DeliveryStatusTypes(
              tYPNM: 'Delivering',
              tYPNO: '4',
              color: AppColors.darkGreen,
            ),
          ],
        );
        _orderStatusTpes.firstWhere((element) => element.tYPNO == '1').color =
            AppColors.darkGreyColor;
        _orderStatusTpes.firstWhere((element) => element.tYPNO == '2').color =
            AppColors.redColor;
        _orderStatusTpes.firstWhere((element) => element.tYPNO == '3').color =
            AppColors.redColor;
      }
    }
  }

  void notify() {
    notifyListeners();
  }

  void setNewAndOthersOrders() {}
}
