import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme.dart';

class SecondaryElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final double? height;
  const SecondaryElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppTheme.bgtrans,
        minimumSize: Size(double.infinity, height ?? 40.h),
        side: BorderSide(
          color: Theme.of(context).colorScheme.onSurface,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
