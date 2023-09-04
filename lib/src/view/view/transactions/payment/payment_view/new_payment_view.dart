import 'dart:developer';

import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//widgets/custom_back_btn.dart';
import 'package:evantez/src/view/core//widgets/custom_dropdown_search.dart';
import 'package:evantez/src/view/core//widgets/custom_radio_button.dart';
import 'package:evantez/src/view/core//widgets/custom_textfield.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:evantez/src/view/core//widgets/tab_bar.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/themes/typography.dart';

class NewPaymentView extends StatelessWidget {
  NewPaymentView({super.key});

  final ValueNotifier<int> selectedTab = ValueNotifier<int>(0);

  final ValueNotifier<double> dueAmt = ValueNotifier<double>(0);

  final ValueNotifier<bool> boyPayType = ValueNotifier<bool>(false);

  final ValueNotifier<String> selectedPayType = ValueNotifier<String>('Event Based');

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: selectedTab,
          builder: (context, value, child) {
            return SizedBox(
              height: kSize.height,
              width: kSize.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius),
                child: Column(
                  children: [
                    appBar(context, kSize),
                    SizedBox(
                      height: kSize.height * 0.032,
                    ),
                    CustomTabBarView(
                      tabItems: const ["Receive", "Pay"],
                      selectedTap: (value) {
                        selectedTab.value = value;
                      },
                    ),
                    selectedTab.value == 0 ? receiveTab(kSize) : payTab(kSize),
                  ],
                ),
              ),
            );
          }),
    );
  }

  AppBar appBar(BuildContext context, Size kSize) {
    return AppBar(
      elevation: 0,
      leading: const CustomBackButton(
        isPaddingZero: 0,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        AppStrings.paymentText,
        style: AppTypography.poppinsSemiBold.copyWith(
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }

  Widget receiveTab(Size kSize) {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: kSize.height * 0.032,
          ),
          const CustomDropdownSearch(
            label: 'Event ID',
            items: ["HHHHHHHH", "JJJJJJJJ", "KKKKKKKK", "LLLLL"],
          ),
          SizedBox(
            height: kSize.height * 0.024,
          ),
          CustomTextField(
            text: AppStrings.customerName,
            style: AppTypography.poppinsRegular.copyWith(color: AppColors.secondaryColor),
            labelStyle:
                AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor.withOpacity(0.6)),
          ),
          SizedBox(
            height: kSize.height * 0.024,
          ),
          CustomTextField(
            text: AppStrings.invAmountText,
            style: AppTypography.poppinsMedium.copyWith(fontSize: 16, color: AppColors.secondaryColor),
            labelStyle:
                AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor.withOpacity(0.6)),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(
                '₹',
                style: AppTypography.poppinsRegular.copyWith(
                  color: AppColors.secondaryColor.withOpacity(0.6),
                  fontSize: 22,
                ),
              ),
            ),
          ),
          SizedBox(
            height: kSize.height * 0.032,
          ),
          Divider(
            color: AppColors.secondaryColor.withOpacity(0.2),
          ),
          SizedBox(
            height: kSize.height * 0.032,
          ),
          Text(
            AppStrings.paymentText,
            style: AppTypography.poppinsSemiBold.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: kSize.height * 0.032,
          ),
          const CustomDropdownSearch(
            label: 'Receive',
            items: ['Advance', 'Cash', 'Online Transfer'],
            hintText: "Payment Type",
          ),
          SizedBox(
            height: kSize.height * 0.024,
          ),
          CustomTextField(
            text: AppStrings.amountText,
            onChanged: (value) {
              //
            },
          ),
          pendingDueAmount(),
          SizedBox(
            height: kSize.height * 0.072,
          ),
          FooterButton(
              label: AppStrings.saveText,
              onTap: () {
                //
              }),
          SizedBox(
            height: kSize.height * 0.2,
          ),
        ],
      ),
    ));
  }

  Widget payTab(Size kSize) {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: kSize.height * 0.032,
          ),
          const CustomDropdownSearch(
            label: AppStrings.categoryText,
            items: ['Head'],
          ),
          SizedBox(
            height: kSize.height * 0.024,
          ),
          const CustomDropdownSearch(
            label: AppStrings.employeeText,
            items: [
              'EV - 152 John Doe',
              'EV - 153 Jane Doe',
            ],
          ),
          SizedBox(
            height: kSize.height * 0.032,
          ),
          Divider(
            color: AppColors.secondaryColor.withOpacity(0.2),
          ),
          SizedBox(
            height: kSize.height * 0.032,
          ),
          Text(
            AppStrings.paymentText,
            style: AppTypography.poppinsSemiBold.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: kSize.height * 0.032,
          ),
          CustomRadioButton(
            items: const [
              "Event Based",
              "Due Based",
            ],
            onSelected: (selected) {
              log(selected);
              selectedPayType.value = selected;
            },
          ),
          SizedBox(
            height: kSize.height * 0.018,
          ),
          ValueListenableBuilder(
              valueListenable: selectedPayType,
              builder: (context, value, child) {
                return (value == "Event Based")
                    ? Padding(
                        padding: EdgeInsets.only(bottom: kSize.height * 0.018),
                        child: const CustomDropdownSearch(
                          textAlignCenter: true,
                          label: "Event ID",
                          hintText: 'Select Event ID',
                          items: ["EV - 188", "EV - 187", "EV - 186"],
                        ),
                      )
                    : const SizedBox();
              }),
          dueAmout(),
          pendingDueAmount(),
          SizedBox(
            height: kSize.height * 0.032,
          ),
          const CustomTextField(
            text: 'Notes',
            maxLines: 3,
          ),
          SizedBox(
            height: kSize.height * 0.2,
          )
        ],
      ),
    ));
  }

  Widget dueAmout() {
    return CustomTextField(
      text: AppStrings.amountText,
      onChanged: (value) {
        //
      },
    );
  }

  Widget pendingDueAmount() {
    return ValueListenableBuilder(
        valueListenable: dueAmt,
        builder: (context, value, child) {
          return Text(
            "Due Amount : ₹ $value",
            style: AppTypography.poppinsRegular.copyWith(color: AppColors.secondaryColor.withOpacity(0.6)),
          );
        });
  }
}
