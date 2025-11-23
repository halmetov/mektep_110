import 'package:flutter/material.dart';
import '../theme/colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool outlined;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: outlined ? AppColors.white : AppColors.tiffanyBlue,
        foregroundColor: outlined ? AppColors.tiffanyBlue : AppColors.white,
        side: outlined ? const BorderSide(color: AppColors.tiffanyBlue, width: 1.4) : null,
        elevation: outlined ? 0 : 2,
      ),
      child: Text(label),
    );
    return SizedBox(
      width: double.infinity,
      child: button,
    );
  }
}
