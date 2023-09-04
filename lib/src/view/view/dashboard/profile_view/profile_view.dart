import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/themes/colors.dart';
import '../../../core/themes/typography.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return SizedBox(
      height: kSize.height,
      width: kSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appBar(context, kSize),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: kSize.height * 0.020,
                    ),
                    displayDetail(kSize),
                    SizedBox(
                      height: kSize.height * 0.024,
                    ),
                    Divider(
                      color: AppColors.secondaryColor.withOpacity(0.1),
                    ),
                    SizedBox(
                      height: kSize.height * 0.016,
                    ),
                    Text(
                      'Personal Information',
                      style: AppTypography.poppinsSemiBold
                          .copyWith(color: AppColors.secondaryColor, fontSize: 24),
                    ),
                    SizedBox(
                      height: kSize.height * 0.016,
                    ),
                    profileDetail(kSize, "Age", "26"),
                    profileDetail(kSize, "Blood Group", "o+ve"),
                    profileDetail(kSize, "Phone", "+91 999999999999"),
                    SizedBox(
                      height: kSize.height * 0.008,
                    ),
                    Divider(
                      color: AppColors.secondaryColor.withOpacity(0.1),
                    ),
                    SizedBox(
                      height: kSize.height * 0.024,
                    ),
                    Text(
                      'Address',
                      style: AppTypography.poppinsSemiBold.copyWith(
                        color: AppColors.secondaryColor,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: kSize.height * 0.0010,
                    ),
                    Text(
                      'Pallikkal House,\nKondotty PO\n676085, Malappuram',
                      style: AppTypography.poppinsRegular.copyWith(
                        color: AppColors.secondaryColor.withOpacity(0.6),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: kSize.height * 0.024,
                    ),
                    Divider(
                      color: AppColors.secondaryColor.withOpacity(0.1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context, Size kSize) {
    return AppBar(
      elevation: 0,
      leading: const SizedBox(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        AppStrings.profileText,
        style: AppTypography.poppinsSemiBold.copyWith(
          color: AppColors.secondaryColor,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            //
            // Navigator.pushNamed(context, RouterConstants.newPaymentRoute);
          },
          icon: SvgPicture.asset(
            AppImages.edit,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
        )
      ],
    );
  }

  Widget displayDetail(Size kSize) {
    return Row(
      children: [
        CircleAvatar(
          maxRadius: kSize.height * 0.040,
          minRadius: kSize.height * 0.040,
        ),
        SizedBox(
          width: kSize.width * 0.024,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Rasheed',
              style: AppTypography.poppinsMedium.copyWith(color: AppColors.primaryColor, fontSize: 24),
            ),
            SizedBox(
              height: kSize.height * 0.005,
            ),
            Text(
              'Admin',
              style: AppTypography.poppinsMedium.copyWith(
                color: AppColors.secondaryColor,
                fontSize: 14,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget profileDetail(Size kSize, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: kSize.height * 0.016),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          label,
          style: AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor, fontSize: 14),
        ),
        Text(value,
            style: AppTypography.poppinsMedium.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 14,
            )),
      ]),
    );
  }
}
