import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../data/models/login/login_request_model.dart';
import '../../../../../providers/auth/auth_provider.dart';
import '../../../../../services/alerts/alerts.dart';
import '../../../../../services/log/app_log.dart';
import '../../../../../services/validators/velidate_check.dart';
import '../../shared_widgets/custom_buttons.dart';
import '../../shared_widgets/custom_text_fields.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopCard(),
            SizedBox(
              height: 60,
            ),
            LoginForm()
          ],
        ),
      ),
    );
  }
}

class TopCard extends StatelessWidget {
  const TopCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 56,
              left: 16,
              right: 16,
            ),
            child: SvgPicture.asset(
              'assets/images/logo_with_title.svg',
              width: 170,
              height: 74,
            ),
          ),
          const Spacer(),
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/v3.svg',
                height: 127,
              ),
              Positioned(
                right: 16,
                child: GestureDetector(
                  onTap: () async {
                    Alerts.showChangeLanguageDialog(context).then((value) {
                      if (value != null) {
                        context.setLocale(
                          context.supportedLocales.firstWhere(
                              (element) => element.languageCode == value),
                        );
                      }
                    });
                  },
                  child: SvgPicture.asset(
                    'assets/images/v4.svg',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _userIdControllre = TextEditingController();

  final TextEditingController _passwordControllre = TextEditingController();

  final FocusNode userIdFocus = FocusNode();

  final FocusNode passwordFocus = FocusNode();

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  Future<void> login() async {
    MyLog.log(_loginFormKey.currentState!.validate());
    if (_loginFormKey.currentState!.validate()) {
      LoginRequestModel loginRequestModel = LoginRequestModel(
        value: Value(
          pDLVRYNO: _userIdControllre.text.trim(),
          pPSSWRD: _passwordControllre.text.trim(),
        ),
      );
      MyLog.log(loginRequestModel.toString());

      await Provider.of<AuthProvider>(context, listen: false)
          .login(loginRequestModel);
    }
  }

  @override
  void dispose() {
    _userIdControllre.dispose();
    _passwordControllre.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: Text(
                  'welcomeBack'.tr(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Center(
                child: Text(
                  'logbackIntoYourAccount'.tr(),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomTextField1(
                controller: _userIdControllre,
                focusNode: userIdFocus,
                nextFocus: passwordFocus,
                hintText: 'userId'.tr(),
                textAlign: TextAlign.center,
                validator: (value) =>
                    ValidateCheck.validateEmptyText(value, null),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomPasswordTextField(
                controller: _passwordControllre,
                focusNode: passwordFocus,
                hintText: 'password'.tr(),
                textAlign: TextAlign.center,
                validator: (value) =>
                    ValidateCheck.validateEmptyText(value, null),
              ),
              const SizedBox(
                height: 12,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'showMore'.tr(),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              CustomButtonWithLoading(
                title: 'login'.tr(),
                function: () async {
                  await login();
                },
                backgroundColor: Theme.of(context).colorScheme.primary,
                textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(
                height: 36,
              ),
              Center(
                child: SvgPicture.asset(
                  'assets/images/v5.svg',
                  height: 170,
                  width: 195,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
