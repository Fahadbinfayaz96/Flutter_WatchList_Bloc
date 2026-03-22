import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final double? height;
  const PrimaryElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, height ?? 40.h),
      ),
      child: Text(buttonText, textAlign: TextAlign.center),
    );
  }
}
