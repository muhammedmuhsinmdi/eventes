import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/view/core/constants/app_images.dart';
import 'package:evantez/src/view/core/widgets/custom_rating_star.dart';
import 'package:evantez/src/view/core/widgets/footer_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/colors.dart';
import '../../../core/themes/typography.dart';
import '../../../core/widgets/custom_back_btn.dart';

class BoyExitRecord extends StatelessWidget {
  const BoyExitRecord({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, kSize),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            messageIcon(kSize),
            const Spacer(
              flex: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppConstants.baseBorderRadius, horizontal: AppConstants.basePadding),
              child: Text(
                'Exit time recorded',
                textAlign: TextAlign.center,
                style: AppTypography.poppinsSemiBold.copyWith(fontSize: 24),
              ),
            ),
            Text(
              'Suhail K',
              textAlign: TextAlign.center,
              style: AppTypography.poppinsSemiBold.copyWith(fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.baseBorderRadius),
              child: Text(
                'A Boy',
                textAlign: TextAlign.center,
                style: AppTypography.poppinsSemiBold.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.baseBorderRadius),
              child: Text(
                "Rate Sahal's Performance",
                textAlign: TextAlign.center,
                style: AppTypography.poppinsSemiBold.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 14,
                ),
              ),
            ),
            CustomRatingStar(
                hideValue: true,
                ignoreGestures: true,
                height: kSize.height * 0.024,
                onRating: (value) {
                  //
                }),
            Padding(
              padding: EdgeInsets.only(top: kSize.height * 0.024),
              child: Text(
                'Marriage Function at\nNova Auditorium\n\nEV-4544',
                textAlign: TextAlign.center,
                style: AppTypography.poppinsSemiBold
                    .copyWith(fontSize: 18, color: AppColors.secondaryColor.withOpacity(0.6)),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            FooterButton(
                label: "Continue",
                onTap: () {
                  //
                  Navigator.pushNamed(context, RouterConstants.boyEarlyExitRoute);
                }),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget messageIcon(Size kSize) {
    return SvgPicture.asset(
      AppImages.msgSuccess,
      height: kSize.height * 0.1,
      colorFilter: const ColorFilter.mode(AppColors.statusSuccess, BlendMode.srcIn),
    );
  }

  AppBar appBar(BuildContext context, Size kSize) {
    return AppBar(
      elevation: 0,
      leading: const CustomBackButton(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        "Success",
        style: AppTypography.poppinsSemiBold.copyWith(
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }
}
