import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../services/theme/app_theme.dart';

class SwtichLangaugeButtons extends StatefulWidget {
  final String initialLanguageCode;
  final ValueChanged<String> onChange;
  const SwtichLangaugeButtons({
    super.key,
    required this.initialLanguageCode,
    required this.onChange,
  });

  @override
  State<SwtichLangaugeButtons> createState() => _SwtichLangaugeButtonsState();
}

class _SwtichLangaugeButtonsState extends State<SwtichLangaugeButtons> {
  bool _isEnglish = true;
  @override
  void initState() {
    _isEnglish = widget.initialLanguageCode == "en";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              widget.onChange('en');
              setState(() {
                _isEnglish = true;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: _isEnglish ? AppColors.lightGreen : Colors.white,
                border: Border.all(
                  color:
                      _isEnglish ? AppColors.greenBorder : AppColors.blueBorder,
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SvgPicture.asset(
                    'assets/images/en_flag.svg',
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'English',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkGreen,
                                ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'English',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkGreen,
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              widget.onChange('ar');
              setState(() {
                _isEnglish = false;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: !_isEnglish ? AppColors.lightGreen : Colors.white,
                border: Border.all(
                  color: !_isEnglish
                      ? AppColors.greenBorder
                      : AppColors.blueBorder,
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SvgPicture.asset(
                    'assets/images/ar_flag.svg',
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'العربية',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkGreen,
                                ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Arabic',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkGreen,
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
