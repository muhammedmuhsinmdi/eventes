import 'package:evantez/src/view/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/typography.dart';
import '../../../../core/widgets/custom_back_btn.dart';
import '../../../../core/widgets/custom_textfield.dart';

class EmployeeDuesReport extends StatelessWidget {
  const EmployeeDuesReport({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, kSize),
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Column(
          children: [
            searchField(kSize),
            todayDuesTile(kSize),
            listHeader(kSize),
            listingDues(kSize, context),
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context, Size kSize) {
    return AppBar(
      elevation: 0,
      leading: const CustomBackButton(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        AppStrings.employeeDuesText,
        style: AppTypography.poppinsSemiBold.copyWith(
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }

  Widget searchField(Size kSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppConstants.largePadding, horizontal: AppConstants.baseBorderRadius),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: CustomTextField(
              text: '',
              hintText: AppStrings.searchText,
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: SvgPicture.asset(
                  AppImages.search,
                  colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                ),
              ),
            ),
          ),
          SizedBox(
            width: kSize.width * 0.032,
          ),
          SizedBox(
            width: kSize.width * 0.1,
            child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                ),
                onPressed: () {
                  //
                },
                child: SvgPicture.asset(
                  AppImages.filter,
                  colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                )),
          )
        ],
      ),
    );
  }

  Widget todayDuesTile(Size kSize) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kSize.height * 0.024, vertical: AppConstants.marginSpace),
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius),
      width: kSize.width,
      decoration: BoxDecoration(color: AppColors.accentColor, borderRadius: BorderRadius.circular(8.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.totalText,
            style: AppTypography.poppinsMedium.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 14,
            ),
          ),
          Text(
            '₹ 124,4121',
            style: AppTypography.poppinsMedium.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }

  Widget listHeader(Size kSize) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: kSize.height * 0.02,
        horizontal: AppConstants.baseBorderRadius + AppConstants.basePadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.employeeText,
            style: AppTypography.poppinsMedium.copyWith(
              color: AppColors.secondaryColor.withOpacity(0.4),
              fontSize: 14,
            ),
          ),
          Text(
            AppStrings.categoryText,
            style: AppTypography.poppinsMedium.copyWith(
              color: AppColors.secondaryColor.withOpacity(0.4),
              fontSize: 14,
            ),
          ),
          Text(
            AppStrings.amountText,
            style: AppTypography.poppinsMedium.copyWith(
              color: AppColors.secondaryColor.withOpacity(0.4),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget listingDues(Size kSize, BuildContext context) {
    return Expanded(
        child: ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius),
      itemBuilder: (context, index) {
        return Container(
          width: kSize.width,
          decoration: BoxDecoration(
              color: AppColors.secondaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius)),
          padding: EdgeInsets.symmetric(
            vertical: kSize.height * 0.016,
            horizontal: AppConstants.basePadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Suhail",
                style: AppTypography.poppinsMedium.copyWith(
                  color: AppColors.secondaryColor.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
              Text(
                'A Boy',
                style: AppTypography.poppinsMedium.copyWith(
                  color: AppColors.secondaryColor.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
              Text(
                '76734',
                style: AppTypography.poppinsMedium.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: AppConstants.baseTextFieldBorderRdious,
        );
      },
      itemCount: 10,
    ));
  }
}
