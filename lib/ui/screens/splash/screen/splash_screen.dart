import 'package:deliveryapp/providers/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/constants/constants.dart';
import '../../../../serivce_locator.dart';
import '../../../../services/theme/app_theme.dart';
import '../../auth/login/screen/login_screen.dart';
import '../../onboard/screen/onboard_screen.dart';
import '../../orders/orders_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash-screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _top = 0;
  double _right = -270;
  @override
  void initState() {
    playAnimation();
    navigate();
    super.initState();
  }

  void navigate() {
    final bool isFirstOpen = serviceLocator<SharedPreferences>().getBool(
          Constants.isFirstOpenKey,
        ) ??
        true;
    final bool isLogin =
        Provider.of<AuthProvider>(context, listen: false).getLoginStatus();
    Future.delayed(
      const Duration(seconds: 3),
    ).then(
      (value) => isFirstOpen
          ? Navigator.of(context).pushReplacementNamed(OnboardScreen.routeName)
          : isLogin
              ? Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName)
              : Navigator.of(context)
                  .pushReplacementNamed(LoginScreen.routeName),
    );
  }

  void playAnimation() async {
    // WidgetsBinding.instance.addPostFrameCallback((_) {});
    Future.delayed(Duration.zero).then(
      (value) => setState(() {
        _top = (MediaQuery.sizeOf(context).height / 2) - (280 / 2);
        _right = (MediaQuery.sizeOf(context).width / 2) - (270 / 2);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashColor,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 40,
                child: SvgPicture.asset(
                  'assets/images/v2.svg',
                  height: 245,
                  width: MediaQuery.sizeOf(context).width,
                ),
              ),
              AnimatedPositioned(
                top: _top,
                duration: const Duration(milliseconds: 1500),
                child: SvgPicture.asset(
                  'assets/images/logo_with_title.svg',
                  height: 180, //260,
                  width: 280,
                ),
              ),
              AnimatedPositioned(
                right: _right,
                bottom: 20,
                duration: const Duration(milliseconds: 1200),
                child: SvgPicture.asset(
                  'assets/images/v1.svg',
                  height: 210,
                  width: 270,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
