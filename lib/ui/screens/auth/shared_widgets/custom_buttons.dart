import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomButtonWithLoading extends StatefulWidget {
  final String title;
  final Color backgroundColor;
  final TextStyle? textStyle;
  final Future<void> Function() function;
  const CustomButtonWithLoading({
    super.key,
    required this.title,
    required this.function,
    required this.backgroundColor,
    required this.textStyle,
  });

  @override
  State<CustomButtonWithLoading> createState() =>
      _CustomButtonWithLoadingState();
}

class _CustomButtonWithLoadingState extends State<CustomButtonWithLoading> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? SpinKitFadingFour(
            color: Theme.of(context).colorScheme.primary,
          )
        : ElevatedButton(
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              await widget.function();
              setState(() {
                _isLoading = false;
              });
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              backgroundColor: widget.backgroundColor,
              fixedSize: Size(
                MediaQuery.sizeOf(context).width,
                44,
              ),
            ),
            child: Text(
              widget.title,
              style: widget.textStyle,
            ),
          );
  }
}
