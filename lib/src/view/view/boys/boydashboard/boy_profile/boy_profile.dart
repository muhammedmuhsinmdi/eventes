import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../app/router/router_constant.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/typography.dart';
import '../../../../core/widgets/custom_rating_star.dart';

class BoyProfileView extends StatelessWidget {
  const BoyProfileView({super.key});

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
                    profileDetail(kSize, "Home Contact", "+91 888888888"),
                    profileDetail(kSize, AppStrings.email, 'suhail@gmail.com'),
                    SizedBox(
                      height: kSize.height * 0.008,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: kSize.height * 0.024),
                      child: Divider(
                        color: AppColors.secondaryColor.withOpacity(0.1),
                      ),
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
                    Text(
                      'Payment Details',
                      style: AppTypography.poppinsSemiBold.copyWith(
                        color: AppColors.secondaryColor,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: kSize.height * 0.016),
                      child: Text(
                        'Bank Details',
                        style: AppTypography.poppinsMedium.copyWith(
                          color: AppColors.secondaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      '1231348567496789\nIFHDF123\nHDFC BANK\Thondayad Branch',
                      style: AppTypography.poppinsRegular.copyWith(
                        color: AppColors.secondaryColor.withOpacity(0.6),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: kSize.height * 0.024,
                    ),
                    Text(
                      'UPI Id',
                      style: AppTypography.poppinsMedium.copyWith(
                        color: AppColors.secondaryColor,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '123@okicici',
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
                    SizedBox(
                      height: kSize.height * 0.024,
                    ),
                    Text(
                      'Earnings',
                      style: AppTypography.poppinsSemiBold.copyWith(
                        color: AppColors.secondaryColor,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: kSize.height * 0.0010,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: kSize.height * 0.016),
                      child: Text(
                        'Total Earnings',
                        style: AppTypography.poppinsMedium.copyWith(
                          color: AppColors.secondaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      '₹ 20568',
                      style: AppTypography.poppinsRegular.copyWith(
                        color: AppColors.secondaryColor.withOpacity(0.6),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: kSize.height * 0.2,
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
            Navigator.pushNamed(context, RouterConstants.boyEditProfileRoute);
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
              'Suhail Pallikkal',
              style: AppTypography.poppinsMedium.copyWith(color: AppColors.primaryColor, fontSize: 24),
            ),
            SizedBox(
              height: kSize.height * 0.005,
            ),
            Text(
              'B Boy',
              style: AppTypography.poppinsMedium.copyWith(
                color: AppColors.secondaryColor,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: kSize.height * 0.005,
            ),
            CustomRatingStar(
                hideValue: false,
                ignoreGestures: true,
                initialRating: 4.0,
                height: kSize.height * 0.018,
                onRating: (value) {
                  //
                }),
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
