import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../data/constants/constants.dart';
import '../../../../data/models/onboard/onboard_model.dart';
import '../../../../serivce_locator.dart';
import '../../../../services/theme/app_theme.dart';
import '../../auth/login/screen/login_screen.dart';

class OnboardScreen extends StatefulWidget {
  static const routeName = '/onboard';
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController _pageController = PageController();
  final List<OnboardModel> _onboardList = [
    OnboardModel(
      title: 'Welcome To Delivery App',
      body: 'Order Anything you want',
      imagePath: 'assets/images/1.svg',
    ),
    OnboardModel(
      title: 'Real time',
      body: 'Real time tracking',
      imagePath: 'assets/images/2.svg',
    ),
    OnboardModel(
      title: 'Fast Delivery',
      body: 'By Mohamed Ayman',
      imagePath: 'assets/images/3.svg',
    ),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () async {
                  serviceLocator<SharedPreferences>()
                      .setBool(
                        Constants.isFirstOpenKey,
                        false,
                      )
                      .then(
                        (value) => Navigator.of(context).pushReplacementNamed(
                          LoginScreen.routeName,
                        ),
                      );
                },
                child: Text(
                  'Skip',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .65,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _onboardList.length,
                      itemBuilder: (context, index) {
                        return OnboardItem(
                          onboardModel: _onboardList[index],
                        );
                      },
                      onPageChanged: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    ),
                  ),
                  AnimatedSmoothIndicator(
                    activeIndex: _selectedIndex,
                    count: _onboardList.length,
                    effect: SwapEffect(
                      type: SwapType.zRotation,
                      radius: 9,
                      dotWidth: 9,
                      dotHeight: 9,
                      spacing: 8,
                      dotColor: Theme.of(context).colorScheme.primaryContainer,
                      activeDotColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _selectedIndex == 0
                      ? const SizedBox.shrink()
                      : TextButton(
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Text(
                            'Back',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(),
                          ),
                        ),
                  TextButton(
                    onPressed: () async {
                      if (_selectedIndex + 1 == _onboardList.length) {
                        serviceLocator<SharedPreferences>()
                            .setBool(
                              Constants.isFirstOpenKey,
                              false,
                            )
                            .then(
                              (value) =>
                                  Navigator.of(context).pushReplacementNamed(
                                LoginScreen.routeName,
                              ),
                            );
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      _selectedIndex + 1 == _onboardList.length
                          ? 'Start'
                          : 'Next',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardItem extends StatelessWidget {
  final OnboardModel onboardModel;
  const OnboardItem({
    super.key,
    required this.onboardModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SvgPicture.asset(
            onboardModel.imagePath,
            fit: BoxFit.contain,
            height: MediaQuery.of(context).size.height * .45,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            onboardModel.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.primaryBlack,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            onboardModel.body,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.primaryBlack,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ],
    );
  }
}
