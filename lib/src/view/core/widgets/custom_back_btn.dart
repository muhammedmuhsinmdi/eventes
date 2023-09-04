import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_images.dart';
import '../constants/constants.dart';
import '../themes/colors.dart';

class CustomBackButton extends StatelessWidget {
  final Function()? onTap;
  final double? isPaddingZero;
  const CustomBackButton({super.key, this.onTap, this.isPaddingZero});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return TextButton(
      style: TextButton.styleFrom(
        shape: const CircleBorder(),
        foregroundColor: AppColors.transparent,
        padding: EdgeInsets.only(
            top: AppConstants.basePadding,
            left: isPaddingZero ?? AppConstants.basePadding,
            bottom: AppConstants.basePadding),
      ),
      onPressed: onTap ??
          () {
            Navigator.pop(context);
          },
      child: SizedBox(
        height: kSize.height * 0.1,
        width: kSize.height * 0.1,
        child: SvgPicture.asset(
          AppImages.arrowLeft,
          height: kSize.height * 0.1,
          colorFilter: const ColorFilter.mode(
            AppColors.primaryColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
