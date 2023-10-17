import 'package:evantez/src/view/core/themes/typography.dart';
import 'package:evantez/src/view/core/widgets/custom_drop_down.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/widgets/custom_textfield.dart';
import '../../../../../core/widgets/footer_button.dart';

class FoodItemFilter extends StatefulWidget {
  const FoodItemFilter({super.key});

  @override
  State<FoodItemFilter> createState() => _FoodItemFilterState();
}

class _FoodItemFilterState extends State<FoodItemFilter> {
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return /* Scaffold(
      backgroundColor: AppColors.transparent,
      bottomSheet: */
        Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: EdgeInsets.fromLTRB(AppConstants.baseBorderRadius, AppConstants.baseBorderRadius,
            AppConstants.baseBorderRadius, kSize.height * 0.044),
        child: foodItems(context, kSize),
      ),
    );
  }

  Widget foodItems(BuildContext context, Size kSize) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Spacer(),
            Text(
              "Add Items",
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
          text: "Item Name",
          hintText: "Item Name",
        ),
        SizedBox(
          height: kSize.height * 0.024,
        ),
        CustomDropDown(
          label: 'Item Type',
          items: ['Chicken Biriyani', "Fried Rice", "Chicken Mandi", "Soorbhiyan Rice"],
          hintText: 'Select Item',
        ),
        /* CustomDropdownSearch(
          label: 'Item Type',
          items: ['Chicken Biriyani', "Fried Rice", "Chicken Mandi", "Soorbhiyan Rice"],
          hintText: 'Select Item',
        ), */
        SizedBox(
          height: kSize.height * 0.024,
        ),
        const CustomTextField(
          text: "Unit Type",
          hintText: "KG,Ltr,etc",
        ),
        SizedBox(
          height: kSize.height * 0.024,
        ),
        const CustomTextField(
          text: "Rate",
          hintText: AppStrings.amountText,
        ),
        SizedBox(
          height: kSize.height * 0.032,
        ),
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
              onTap: () {
                //
              },
            ),
          ],
        )
      ],
    );
  }
}
