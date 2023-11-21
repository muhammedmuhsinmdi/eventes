import 'dart:ui';

import 'package:evantez/src/view/core/constants/constants.dart';
import 'package:evantez/src/view/core/themes/colors.dart';
import 'package:evantez/src/view/core/themes/typography.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final Function() onConfirm;
  final String? onConfirmTxt;
  const CustomDialog({super.key, required this.title, required this.onConfirm, this.onConfirmTxt});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: SimpleDialog(
        backgroundColor: AppColors.accentDark,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(
              width: 1,
              color: AppColors.primaryColor,
            )),
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: AppTypography.poppinsRegular.copyWith(
            fontSize: 16,
            color: AppColors.secondaryColor,
          ),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: AppTypography.poppinsMedium.copyWith(
                      fontSize: 14,
                      color: AppColors.secondaryColor,
                    ),
                  )),
              TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: AppConstants.basePadding),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      backgroundColor: onConfirmTxt != null && onConfirmTxt == "Delete"
                          ? AppColors.statusCritical
                          : AppColors.primaryColor),
                  onPressed: onConfirm,
                  child: Text(
                    onConfirmTxt ?? "Confirm",
                    style: AppTypography.poppinsMedium.copyWith(
                      fontSize: 14,
                      color: AppColors.secondaryColor,
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
