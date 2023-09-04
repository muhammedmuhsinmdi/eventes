import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:flutter/material.dart';

class FooterButton extends StatelessWidget {
  final String label;
  final double? width;
  // final double? height;
  final EdgeInsets? padding;
  final Function() onTap;
  final bool isDisable;
  final Color? fillColor;
  final Color? borderColor;
  const FooterButton(
      {super.key,
      required this.label,
      this.width,
      // this.height,
      required this.onTap,
      this.isDisable = false,
      this.fillColor,
      this.borderColor,
      this.padding});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return SizedBox(
      width: width ?? kSize.width,
      child: TextButton(
          style: TextButton.styleFrom(
            side: BorderSide(color: borderColor ?? AppColors.primaryColor),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
            padding: padding ?? const EdgeInsets.symmetric(vertical: AppConstants.marginSpace),
            backgroundColor: fillColor ?? AppColors.primaryColor.withOpacity(isDisable ? 0.5 : 1),
          ),
          onPressed: isDisable ? null : onTap,
          child: Text(
            label,
            style: AppTypography.poppinsSemiBold.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 16,
            ),
          )),
    );
  }
}
