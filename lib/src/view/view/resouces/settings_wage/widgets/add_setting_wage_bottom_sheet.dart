import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/typography.dart';
import '../../../../core/widgets/custom_textfield.dart';

class AddSettingWageBottomSheet {
  BuildContext context;
  AddSettingWageBottomSheet(this.context);

  Future show() async {
    final kSize = MediaQuery.of(context).size;
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppConstants.basePadding),
                topRight: Radius.circular(AppConstants.basePadding))),
        backgroundColor: AppColors.accentDark,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: EdgeInsets.fromLTRB(AppConstants.baseBorderRadius, AppConstants.baseBorderRadius,
                  AppConstants.baseBorderRadius, kSize.height * 0.044),
              child: addSettingWork(context, kSize),
            ),
          );
        });
  }

  Widget addSettingWork(BuildContext context, Size kSize) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Spacer(),
            Text(
              "Add Setting Work",
              style: AppTypography.poppinsSemiBold.copyWith(
                fontSize: 18,
                color: AppColors.secondaryColor,
              ),
            ),
            const Spacer(),
            InkWell(
                highlightColor: AppColors.transparent,
                splashColor: AppColors.transparent,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppStrings.closeText,
                  style: AppTypography.poppinsMedium
                      .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6)),
                ))
          ],
        ),
        SizedBox(
          height: kSize.height * 0.032,
        ),
        const CustomTextField(
          text: "Task Name",
          hintText: "Name",
        ),
        SizedBox(
          height: kSize.height * 0.024,
        ),
        const CustomTextField(
          text: "Task Code",
          hintText: "Code",
        ),
        SizedBox(
          height: kSize.height * 0.024,
        ),
        const CustomTextField(
          text: "Piece Rate",
          hintText: AppStrings.amountText,
        ),
        SizedBox(height: kSize.height * 0.032),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FooterButton(
                fillColor: AppColors.transparent,
                width: kSize.width * 0.4,
                label: "Cancel",
                onTap: () {
                  //
                  Navigator.pop(context);
                }),
            FooterButton(
              width: kSize.width * 0.4,
              label: "Save",
              onTap: () {},
            ),
          ],
        )
      ],
    );
  }
}
