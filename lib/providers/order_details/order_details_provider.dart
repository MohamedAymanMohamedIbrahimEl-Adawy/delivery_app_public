import 'package:flutter/material.dart';

import '../../data/repositories/order_details/order_details_repo.dart';

class OrderDetailsProvider with ChangeNotifier {
  final OrderDetailsRepository _orderDetailsRepository;

  OrderDetailsProvider({required OrderDetailsRepository orderDetailsRepository})
      : _orderDetailsRepository = orderDetailsRepository;
}
