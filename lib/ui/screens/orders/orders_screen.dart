import 'package:deliveryapp/services/theme/app_theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../data/models/orders/order_status_types_response_model.dart';
import '../../../data/models/orders/orders_response_model.dart';
import '../../../providers/auth/auth_provider.dart';
import '../../../providers/order_status_types/order_status_types_provider.dart';
import '../../../providers/orders/orders_provider.dart';
import '../../../services/notifications/notifications_services.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders-screen';

  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isNew = true;

  final List<DeliveryBills> ordersList = [];

  @override
  void initState() {
    NotificationsServices().init();
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    Provider.of<OrderStatusTypesProvider>(context, listen: false)
        .fetch()
        .then((value) {
      Provider.of<OrdersProvider>(context, listen: false).fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const TopCard(),
            const SizedBox(
              height: 16,
            ),
            SwitchCard(
              initialValue: _isNew,
              onTap: (bool value) {
                _isNew = value;
                Provider.of<OrdersProvider>(context, listen: false).notify();
              },
            ),
            Consumer<OrdersProvider>(
              builder: (context, ordersProvider, child) {
                ordersList.clear();
                _isNew
                    ? ordersList.addAll(ordersProvider.getAllOrders
                        .where((element) => element.dLVRYSTATUSFLG == "0"))
                    : ordersList.addAll(ordersProvider.getAllOrders
                        .where((element) => element.dLVRYSTATUSFLG != "0"));

                if (ordersProvider.getIsLoading) {
                  return Center(
                    child: SpinKitFadingFour(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                } else if (ordersList.isEmpty) {
                  return const EmptyOrders();
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: ordersList.length,
                      itemBuilder: (context, index) => OrderItemCard(
                        deliveryBills: ordersList[index],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItemCard extends StatelessWidget {
  final DeliveryBills deliveryBills;
  const OrderItemCard({
    super.key,
    required this.deliveryBills,
  });

  @override
  Widget build(BuildContext context) {
    final List<DeliveryStatusTypes> orderStatusTypes =
        Provider.of<OrderStatusTypesProvider>(context, listen: false)
            .getOrderStatusTypes;

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      surfaceTintColor: Colors.white,
      child: SizedBox(
        height: 120,
        child: Stack(
          children: [
            Positioned(
              top: 8,
              left: 16,
              child: Text(
                '#${deliveryBills.bILLSRL!}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Status',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppColors.greyColor,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        orderStatusTypes
                                .firstWhere((element) =>
                                    element.tYPNO ==
                                    deliveryBills.dLVRYSTATUSFLG)
                                .tYPNM ??
                            '',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: orderStatusTypes
                                      .firstWhere((element) =>
                                          element.tYPNO ==
                                          deliveryBills.dLVRYSTATUSFLG)
                                      .color ??
                                  AppColors.greenColor,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 32),
                  child: VerticalDivider(
                    color: AppColors.dividerColor,
                    width: 1,
                    thickness: 1,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total Price',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppColors.greyColor,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        double.parse(deliveryBills.bILLAMT ?? '')
                                .toStringAsFixed(2) +
                            'LE',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.darkGreen,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 32),
                  child: VerticalDivider(
                    color: AppColors.dividerColor,
                    width: 1,
                    thickness: 1,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Date',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppColors.greyColor,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        deliveryBills.bILLDATE ?? '',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.darkGreen,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: orderStatusTypes
                            .firstWhere((element) =>
                                element.tYPNO == deliveryBills.dLVRYSTATUSFLG)
                            .color ??
                        AppColors.greenColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  width: 60,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Order Details',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyOrders extends StatelessWidget {
  const EmptyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/images/empty.svg',
                  height: 180,
                  width: 224,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'No orders yet',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'You don\'t have any orders in your history.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TopCard extends StatelessWidget {
  const TopCard({super.key});

  @override
  Widget build(BuildContext context) {
    final String name =
        Provider.of<AuthProvider>(context, listen: false).getName;
    return Container(
      height: 127,
      width: MediaQuery.sizeOf(context).width,
      color: AppColors.redColor,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name.split(' ')[0],
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                    ),
                    Text(
                      name.split(' ').length >= 2 ? name.split(' ')[1] : '',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  SvgPicture.asset(
                    'assets/images/v6.svg',
                    height: 127,
                    width: 121,
                  ),
                  Positioned(
                    right: 16,
                    top: 48,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      padding: const EdgeInsets.all(4),
                      child: SvgPicture.asset(
                        'assets/images/v4.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right: 60,
            bottom: 0,
            child: Image.asset(
              'assets/images/boy.png',
              height: 100,
              width: 140,
            ),
          ),
        ],
      ),
    );
  }
}

class SwitchCard extends StatefulWidget {
  final void Function(bool isNew) onTap;
  final bool initialValue;
  const SwitchCard(
      {super.key, required this.onTap, required this.initialValue});

  @override
  State<SwitchCard> createState() => _SwitchCardState();
}

class _SwitchCardState extends State<SwitchCard> {
  bool _isNew = true;
  @override
  void initState() {
    _isNew = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      surfaceTintColor: Colors.white,
      elevation: 5,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isNew = true;
              });
              widget.onTap(_isNew);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _isNew ? AppColors.darkGreen : Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              width: 110,
              padding: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              child: Text(
                'New',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: _isNew ? Colors.white : AppColors.darkGreen,
                    ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isNew = false;
              });
              widget.onTap(_isNew);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _isNew ? Colors.white : AppColors.darkGreen,
                borderRadius: BorderRadius.circular(18),
              ),
              width: 110,
              padding: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              child: Text(
                'Others',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: _isNew ? AppColors.darkGreen : Colors.white,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
