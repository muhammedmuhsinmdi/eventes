import 'package:evantez/src/model/repository/auth/auth_controller.dart';
import 'package:evantez/src/model/repository/resource/rentalitem_repository.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/themes/typography.dart';
import '../../../../../core/widgets/custom_textfield.dart';

class AddRentalItems {
  BuildContext context;
  int index;
  AddRentalItems(this.context, this.index);

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
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  AppConstants.baseBorderRadius,
                  AppConstants.baseBorderRadius,
                  AppConstants.baseBorderRadius,
                  kSize.height * 0.044),
              child: rentalItems(context, kSize),
            ),
          );
        });
  }

  Widget rentalItems(BuildContext context, Size kSize) {
    final controller = context.watch<RentalItemsController>();
    final auth = context.watch<AuthController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Spacer(),
            Text(
              controller.isEdit ? "Update Items" : "Add Items",
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
                  style: AppTypography.poppinsMedium.copyWith(
                      fontSize: 14,
                      color: AppColors.secondaryColor.withOpacity(0.6)),
                ))
          ],
        ),
        SizedBox(
          height: kSize.height * 0.032,
        ),
        CustomTextField(
          text: "Item Name",
          hintText: "Item Name",
          controller: controller.itemNameController,
        ),
        SizedBox(
          height: kSize.height * 0.024,
        ),
        CustomTextField(
          text: "Item Code",
          controller: controller.itemCodeController,
          hintText: "Code",
        ),
        SizedBox(
          height: kSize.height * 0.024,
        ),
        CustomTextField(
          text: "Rent",
          controller: controller.rentController,
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
              label: controller.isEdit ? "Update" : "Save",
              onTap: () {
                //
                if (controller.isEdit) {
                  controller.editRentalItem(
                      token: auth.accesToken ?? '',
                      context: context,
                      id: controller.rentalItemsList[index].id);
                } else {
                  controller
                      .addRentalItems(
                          token: auth.accesToken ?? '', context: context)
                      .then((value) {
                    controller.rentalItemList(token: auth.accesToken ?? '');
                  });
                }
              },
            ),
          ],
        )
      ],
    );
  }
}
