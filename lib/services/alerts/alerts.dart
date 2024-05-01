import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../ui/shared_widgets/swtich_langauge_buttons.dart';
import '../theme/app_theme.dart';

class Alerts {
  static Future<dynamic> showAlertNoAction({
    required String title,
    required BuildContext context,
    String? outputAction,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog.adaptive(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              25,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 4,
                  bottom: 8,
                ),
                child: Text(
                  title.tr(),
                  textScaler: const TextScaler.linear(1),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(outputAction);
                          },
                          child: Text(
                            'okay'.tr(),
                            textScaler: const TextScaler.linear(1),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<dynamic> showAlertYesOrNo({
    required String title,
    required BuildContext context,
    String actionButtonTitleYes = 'yes',
    String actionButtonTitleNo = 'no',
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog.adaptive(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 4,
                bottom: 8,
              ),
              child: Text(
                title.tr(),
                textScaler: const TextScaler.linear(1),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 16,
                    ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(
                        actionButtonTitleYes.tr(),
                        textScaler: const TextScaler.linear(1),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(
                        actionButtonTitleNo.tr(),
                        textScaler: const TextScaler.linear(1),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  static Future<dynamic> showChangeLanguageDialog(BuildContext context) async {
    String initialLanguageCode = context.locale.languageCode;
    return showAdaptiveDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) => AlertDialog.adaptive(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'chooseLanguage'.tr(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkGreen,
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            SwtichLangaugeButtons(
              onChange: (value) => initialLanguageCode = value,
              initialLanguageCode: initialLanguageCode,
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, initialLanguageCode);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkGreen,
                fixedSize: Size(MediaQuery.sizeOf(context).width, 44),
              ),
              child: Text(
                'apply'.tr(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
