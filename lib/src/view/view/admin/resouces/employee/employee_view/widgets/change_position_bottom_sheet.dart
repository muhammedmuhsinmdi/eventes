import 'dart:developer';

import 'package:evantez/src/controller/resources/employee/employee_controller.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core/widgets/drop_down_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/app_images.dart';
import '../../../../../../core/constants/app_strings.dart';
import '../../../../../../core/themes/typography.dart';
import '../../../../../../core/widgets/custom_textfield.dart';

class ChangeEmpPosition {
  BuildContext parentContext;
  List<DropDownValue> positions;
  ChangeEmpPosition({
    required this.parentContext,
    required this.positions,
  });

  Future show() async {
    // final controller = context.watch();
    final kSize = MediaQuery.of(parentContext).size;
    await showModalBottomSheet(
        context: parentContext,
        backgroundColor: AppColors.accentDark,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppConstants.basePadding),
                topRight: Radius.circular(AppConstants.basePadding))),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.fromLTRB(AppConstants.baseBorderRadius,
                kSize.height * 0.032, AppConstants.baseBorderRadius, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                header(context, kSize),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
                searchField(context, kSize),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
                postitonListing(context, kSize),
              ],
            ),
          );
        });
  }

  Widget postitonListing(BuildContext context, Size kSize) {
    final controller = context.watch<EmployeesController>();
    return SizedBox(
      height: kSize.height * 0.4,
      width: kSize.width,
      child: Scrollbar(
        interactive: true,
        thumbVisibility: true,
        trackVisibility: true,
        child: ListView.builder(
          itemCount: positions.length,
          padding: const EdgeInsets.only(bottom: AppConstants.largePadding),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: kSize.height * 0.008),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(AppConstants.basePadding / 2),
                  color: AppColors.secondaryColor.withOpacity(0.1)),
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.basePadding / 2,
                  vertical: AppConstants.basePadding / 2),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      log("Selected Position = ${positions[index].toJson()}");

                      controller.changePosition(positions[index]);
                      Navigator.pop(context);
                    },
                    child: Text(
                      positions[index].value!,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget searchField(BuildContext context, Size kSize) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: CustomTextField(
            text: '',
            hintText: AppStrings.searchText,
            suffixIcon: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: SvgPicture.asset(
                AppImages.search,
                colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor, BlendMode.srcIn),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              ),
              onPressed: () async {
                //
              },
              child: SvgPicture.asset(
                AppImages.filter,
                colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor, BlendMode.srcIn),
              )),
        )
      ],
    );
  }

  Widget header(BuildContext context, Size kSize) {
    return Row(
      children: [
        const Spacer(),
        Text(
          AppStrings.changePositionEmp,
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
              AppStrings.clearText,
              style: AppTypography.poppinsMedium.copyWith(
                  fontSize: 14,
                  color: AppColors.secondaryColor.withOpacity(0.6)),
            ))
      ],
    );
  }
}
