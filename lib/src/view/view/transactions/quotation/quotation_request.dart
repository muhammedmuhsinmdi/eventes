import 'package:evantez/src/view/core/constants/app_strings.dart';
import 'package:evantez/src/view/core/constants/constants.dart';
import 'package:evantez/src/view/core/widgets/footer_button.dart';
import 'package:flutter/material.dart';

import '../../../core/themes/colors.dart';
import '../../../core/themes/typography.dart';
import '../../../core/widgets/custom_back_btn.dart';

class QuotationRequest extends StatelessWidget {
  const QuotationRequest({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, kSize),
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                displayDetail(kSize),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kSize.height * 0.032),
                  child: Divider(
                    color: AppColors.secondaryColor.withOpacity(0.4),
                  ),
                ),
                rowItems(title: AppStrings.eventTypeText, value: 'Wedding'),
                rowItems(title: AppStrings.dateText, value: '3 Nov 2023'),
                rowItems(title: "Time", value: '10:30AM'),
                rowItems(title: AppStrings.phoneText, value: '+91 999999999'),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kSize.height * 0.032),
                  child: Divider(
                    color: AppColors.secondaryColor.withOpacity(0.4),
                  ),
                ),
                rowItems(title: AppStrings.email, value: 'abc@gmail.com'),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kSize.height * 0.032),
                  child: Divider(
                    color: AppColors.secondaryColor.withOpacity(0.4),
                  ),
                ),
                Text(
                  "Notes",
                  style: AppTypography.poppinsMedium.copyWith(
                    color: AppColors.secondaryColor.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Call Immediately",
                  style: AppTypography.poppinsMedium.copyWith(
                    color: AppColors.secondaryColor,
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kSize.height * 0.032),
                  child: Divider(
                    color: AppColors.secondaryColor.withOpacity(0.4),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    AppStrings.address,
                    style: AppTypography.poppinsMedium.copyWith(
                      fontSize: 14,
                      color: AppColors.secondaryColor.withOpacity(0.6),
                    ),
                  ),
                ),
                Text(
                  'Pallikkal House.\nKondotty PO 676085,\nMalappuram',
                  style: AppTypography.poppinsMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.secondaryColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kSize.height * 0.032),
                  child: Divider(
                    color: AppColors.secondaryColor.withOpacity(0.4),
                  ),
                ),
                FooterButton(
                    label: "Call",
                    onTap: () {
                      //call function
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rowItems({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.basePadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTypography.poppinsMedium.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: AppTypography.poppinsMedium.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget displayDetail(Size kSize) {
    return Padding(
      padding: EdgeInsets.only(top: kSize.height * 0.032),
      child: Column(
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
            '+917737747774',
            style: AppTypography.poppinsMedium.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 18,
            ),
          ),
        ],
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
        "Quote Request",
        style: AppTypography.poppinsSemiBold.copyWith(),
      ),
    );
  }
}
