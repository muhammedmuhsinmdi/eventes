import 'dart:developer';

import 'package:evantez/src/model/repository/auth/auth_controller.dart';
import 'package:evantez/src/model/repository/catering/food_items_repository.dart';
import 'package:evantez/src/view/core/themes/typography.dart';
import 'package:evantez/src/view/core/widgets/common_drop_down.dart';
import 'package:evantez/src/view/core/widgets/custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/widgets/custom_textfield.dart';
import '../../../../../core/widgets/footer_button.dart';

class FoodItemFilter extends StatefulWidget {
  const FoodItemFilter({super.key, required this.index});
  final int index;
  @override
  State<FoodItemFilter> createState() => _FoodItemFilterState();
}

class _FoodItemFilterState extends State<FoodItemFilter> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return /* Scaffold(
      backgroundColor: AppColors.transparent,
      bottomSheet: */
        Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: const SizedBox(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Add Items",
          style: AppTypography.poppinsSemiBold.copyWith(
            fontSize: 18,
            color: AppColors.secondaryColor,
          ),
        ),
        centerTitle: true,
        actions: [
          InkWell(
              highlightColor: AppColors.transparent,
              splashColor: AppColors.transparent,
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: kSize.width * 0.016, vertical: kSize.height * 0.020),
                child: Text(
                  AppStrings.closeText,
                  style: AppTypography.poppinsMedium
                      .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6)),
                ),
              ))
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Padding(
          padding: EdgeInsets.fromLTRB(AppConstants.baseBorderRadius, AppConstants.baseBorderRadius,
              AppConstants.baseBorderRadius, kSize.height * 0.044),
          child: foodItems(context, kSize),
        ),
      ),
    );
  }

  Widget foodItems(BuildContext context, Size kSize) {
    final controller = context.watch<FoodItemsController>();
    final auth = context.watch<AuthController>();
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: kSize.height * 0.016,
          ),
          CustomTextField(
            text: "Item Name",
            hintText: "Item Name",
            controller: controller.nameController,
          ),
          SizedBox(
            height: kSize.height * 0.024,
          ),
          CommonDropdown(
            text: "Item Type",
            label: 'Item Type',
            dropDownValue: controller.foodItemTypesList
            /*   const [
              'Chicken Biriyani',
              "Fried Rice",
              "Chicken Mandi",
              "Soorbhiyan Rice"
            ] */
            ,
            hintText: 'Select Item',
            onChanged: (value) {
              controller.changeId(value);
            },
          ),
          /* CustomDropdownSearch(
            label: 'Item Type',
            items: ['Chicken Biriyani', "Fried Rice", "Chicken Mandi", "Soorbhiyan Rice"],
            hintText: 'Select Item',
          ), */
          SizedBox(
            height: kSize.height * 0.024,
          ),
          CustomTextField(
            text: "Unit Type",
            hintText: "KG,Ltr,etc",
            controller: controller.foodItemUnitController,
          ),
          SizedBox(
            height: kSize.height * 0.024,
          ),
          CustomTextField(
            text: "Rate",
            controller: controller.rateController,
            hintText: AppStrings.amountText,
          ),
          SizedBox(
            height: kSize.height * 0.032,
          ),
          const Spacer(),
          if (controller.isloading) ...{
            const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            )
          } else ...{
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

                    if (_formKey.currentState!.validate()) {
                      if (controller.isloading) {
                        if (controller.isEdit) {
                          controller.editFoodItem(
                              token: auth.accesToken ?? '',
                              context: context,
                              id: controller.foodItemsList[widget.index].id!);
                        } else {
                          controller
                              .addFoodItems(token: auth.accesToken ?? '', context: context)
                              .then((value) {
                            controller.foodItemList(token: auth.accesToken ?? '');
                          });
                        }
                      }
                    }
                  },
                ),
              ],
            )
          }
        ],
      ),
    );
  }
}
