import 'package:another_flushbar/flushbar.dart';
import 'package:deliveryapp/services/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Snacks {
  static void showTopSnackBar({
    required BuildContext context,
    required String title,
    required String body,
    int seconds = 2,
  }) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(15),
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 10,
      ),
      boxShadows: [
        BoxShadow(
          color: Theme.of(context).colorScheme.secondary,
          offset: const Offset(0.0, 2.0),
          blurRadius: 3.0,
        )
      ],
      isDismissible: false,
      duration: Duration(seconds: seconds),
      icon: const Icon(
        Icons.check,
        color: AppColors.greenColor,
        size: 27,
      ),
      progressIndicatorBackgroundColor: Theme.of(context).colorScheme.secondary,
      titleText: Text(
        title,
        textScaler: const TextScaler.linear(1),
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.greenColor,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
      ),
      messageText: Text(
        body,
        textScaler: const TextScaler.linear(1),
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
      ),
    ).show(context);
  }

// void showBottomSnackBar({
//   required BuildContext context,
//   required String title,
//   required String body,
//   int seconds = 2,
// }) {
//   Flushbar(
//     flushbarPosition: FlushbarPosition.BOTTOM,
//     flushbarStyle: FlushbarStyle.FLOATING,
//     reverseAnimationCurve: Curves.decelerate,
//     forwardAnimationCurve: Curves.elasticOut,
//     backgroundColor: MyColors.color18,
//     borderRadius: BorderRadius.circular(15),
//     margin: const EdgeInsets.symmetric(
//       horizontal: 8,
//       vertical: 10,
//     ),
//     boxShadows: const [
//       BoxShadow(
//         color: MyColors.color15,
//         offset: Offset(0.0, 2.0),
//         blurRadius: 3.0,
//       )
//     ],
//     duration: Duration(seconds: seconds),
//     icon: const Icon(
//       Icons.check,
//       color: MyColors.color15,
//       size: 27,
//     ),
//     progressIndicatorBackgroundColor: MyColors.color15,
//     titleText: Text(
//       title,
//       textScaler: const TextScaler.linear(1),
//       style: const TextStyle(
//         fontWeight: FontWeight.bold,
//         fontSize: 19.0,
//         color: MyColors.color15,
//       ),
//     ),
//     messageText: Text(
//       body,
//       textScaler: const TextScaler.linear(1),
//       style: const TextStyle(
//         fontSize: 18.0,
//         color: Colors.white,
//       ),
//     ),
//   ).show(context);
// }
}
