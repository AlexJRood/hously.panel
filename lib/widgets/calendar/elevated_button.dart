import 'package:flutter/material.dart';
import 'package:hously_flutter/const/colors.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final OutlinedBorder? shape;
  final Color? bgColor;
  final VoidCallback? onTapped;
  final Widget child;
  final double elevation;

  const ElevatedButtonWidget({
    super.key,
    this.shape,
    this.bgColor,
    required this.onTapped,
    required this.child,
    this.elevation = 1,
  });

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
              ),
          elevation: elevation,
          backgroundColor: bgColor ?? lightBlue,
        ),
        onPressed: onTapped,
        child: child,
      );
}
