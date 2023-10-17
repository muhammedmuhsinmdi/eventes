import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/themes/typography.dart';
import '../../../../../core/widgets/custom_back_btn.dart';

class EmployeeApplicationView extends StatelessWidget {
  const EmployeeApplicationView({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, kSize),
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                empProPicDetail(kSize: kSize, context: context),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
                Divider(
                  color: AppColors.secondaryColor.withOpacity(0.3),
                ),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
                FooterButton(
                  label: "View Resume",
                  onTap: () {
                    //
                  },
                ),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
                Divider(
                  color: AppColors.secondaryColor.withOpacity(0.3),
                ),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
                Text(
                  AppStrings.proInfoText,
                  style: AppTypography.poppinsSemiBold.copyWith(
                    color: AppColors.secondaryColor,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                proInfo('Age', '26'),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                proInfo(AppStrings.bloodGroup, 'O+ve'),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                proInfo(AppStrings.phoneText, '+91 9999999999'),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                proInfo(AppStrings.homeContactText, '+91 9999999999'),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
                Divider(
                  color: AppColors.secondaryColor.withOpacity(0.3),
                ),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
                Text(
                  AppStrings.address,
                  style: AppTypography.poppinsSemiBold.copyWith(
                    color: AppColors.secondaryColor,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                Text(
                  "Pallikkal House.\nKondotty PO\n676085, Malappuram",
                  maxLines: 4,
                  style: AppTypography.poppinsRegular.copyWith(
                    color: AppColors.secondaryColor.withOpacity(0.6),
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
                Divider(
                  color: AppColors.secondaryColor.withOpacity(0.3),
                ),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FooterButton(
                      fillColor: AppColors.transparent,
                      width: kSize.width * 0.40,
                      label: "Reject",
                      onTap: () {
                        //
                      },
                    ),
                    FooterButton(
                      width: kSize.width * 0.40,
                      label: 'Hire',
                      onTap: () {
                        //
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget proInfo(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.poppinsMedium,
        ),
        Text(
          value,
          style: AppTypography.poppinsMedium,
        )
      ],
    );
  }

  AppBar appBar(BuildContext context, Size kSize) {
    return AppBar(
      elevation: 0,
      leading: const CustomBackButton(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        AppStrings.applicationText,
        style: AppTypography.poppinsSemiBold.copyWith(
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }

  Widget empProPicDetail({required Size kSize, required BuildContext context}) {
    return Row(
      children: [
        CircleAvatar(
          radius: kSize.height * 0.050,
        ),
        SizedBox(
          width: kSize.width * 0.018,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Applicant Name',
              maxLines: 2,
              style: AppTypography.poppinsSemiBold.copyWith(fontSize: 24),
            ),
            Text(
              'Malappuram',
              style: AppTypography.poppinsMedium.copyWith(fontSize: 14),
            )
          ],
        )
      ],
    );
  }
}
