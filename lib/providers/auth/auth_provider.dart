import 'package:deliveryapp/data/models/login/login_request_model.dart';
import 'package:deliveryapp/data/models/response/app_response.dart';
import 'package:deliveryapp/services/log/app_log.dart';
import 'package:deliveryapp/services/snacks/snacks.dart';
import 'package:flutter/material.dart';

import '../../data/models/login/login_response_model.dart';
import '../../data/repositories/auth/auth_repo.dart';
import '../../main.dart';
import '../../ui/screens/orders/orders_screen.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository;

  AuthProvider({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Future<void> login(LoginRequestModel loginRequestModel) async {
    late final AppResponse appResponse;

    appResponse = await _authRepository.login(loginRequestModel);

    if (appResponse.hasError) {
      Snacks.showTopSnackBar(
        context: Get.context!,
        title: 'alert',
        body: appResponse.message!,
      );
    } else {
      LoginResponseModel loginResponseModel =
          LoginResponseModel.fromMap(appResponse.data!);

      MyLog.log(loginResponseModel.toString());

      if (loginResponseModel.result?.errNo != 0) {
        Snacks.showTopSnackBar(
          context: Get.context!,
          title: 'alert',
          body: loginResponseModel.result!.errMsg!,
        );
      } else {
        await _authRepository.setLoginStatus(true);
        await _authRepository.setName(loginResponseModel.data!.deliveryName!);
        await _authRepository.setUserId(loginRequestModel.value!.pDLVRYNO!);
        Navigator.of(Get.context!).pushNamed(OrdersScreen.routeName);
      }
    }
  }

  bool getLoginStatus() {
    return _authRepository.getLoginStatus();
  }

  String get getUserId {
    return _authRepository.getUserId();
  }

  String get getName {
    return _authRepository.getName();
  }
}
