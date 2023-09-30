import 'package:evantez/src/view/core/constants/constants.dart';
import 'package:evantez/src/view/core/widgets/custom_back_btn.dart';
import 'package:evantez/src/view/core/widgets/custom_dropdown_search.dart';
import 'package:evantez/src/view/core/widgets/custom_textfield.dart';
import 'package:evantez/src/view/core/widgets/footer_button.dart';
import 'package:evantez/src/view/view/admin/transactions/new_event/widgets/custom_service_counter.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/typography.dart';

class NewQuotationView extends StatelessWidget {
  const NewQuotationView({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar(context, kSize),
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppConstants.baseBorderRadius,
              AppConstants.baseBorderRadius, AppConstants.baseBorderRadius, 0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              quoteNo(kSize),
              Padding(
                padding: EdgeInsets.only(bottom: kSize.height * 0.024),
                child: Text(
                  AppStrings.customerInfoText,
                  style: AppTypography.poppinsSemiBold.copyWith(
                    color: AppColors.secondaryColor,
                    fontSize: 18,
                  ),
                ),
              ),
              customerNameField(kSize, context),
              eventVenueField(kSize, context),
              eventTypeDropDown(kSize, context),
              addressField(kSize, context),
              phoneField(kSize, context),
              Padding(
                padding: EdgeInsets.symmetric(vertical: kSize.height * 0.032),
                child: Divider(
                  color: AppColors.secondaryColor.withOpacity(0.4),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: kSize.height * 0.024),
                child: Row(
                  children: [
                    Text(
                      "Rental & Services",
                      style: AppTypography.poppinsSemiBold.copyWith(
                        fontSize: 18,
                        color: AppColors.secondaryColor,
                      ),
                    )
                  ],
                ),
              ),
              CustomServiceCounter(
                  label: "", items: const ['Ceramic Plates', 'House ']),
              CustomServiceCounter(
                  label: "", items: const ['Ceramic Plates', 'House ']),
              SizedBox(
                height: kSize.height * 0.032,
              ),
              serviceRentalBtn(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: kSize.height * 0.032),
                child: Divider(
                  color: AppColors.secondaryColor.withOpacity(0.4),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: kSize.height * 0.024),
                child: Row(
                  children: [
                    Text(
                      "Services Boys",
                      style: AppTypography.poppinsSemiBold.copyWith(
                        fontSize: 18,
                        color: AppColors.secondaryColor,
                      ),
                    )
                  ],
                ),
              ),
              CustomServiceCounter(label: "", items: const ['Head', 'A Boy ']),
              CustomServiceCounter(
                  label: "", items: const ['B Boy', 'Captain']),
              SizedBox(
                height: kSize.height * 0.032,
              ),
              FooterButton(
                  fillColor: AppColors.transparent,
                  label: 'Add +',
                  onTap: () {
                    //
                  }),
              Padding(
                padding: EdgeInsets.symmetric(vertical: kSize.height * 0.032),
                child: Divider(
                  color: AppColors.secondaryColor.withOpacity(0.4),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: kSize.height * 0.032),
                child: Text(
                  "Summary",
                  style: AppTypography.poppinsSemiBold.copyWith(
                    fontSize: 24,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: kSize.height * 0.016),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rental & Services",
                      style: AppTypography.poppinsMedium.copyWith(
                        fontSize: 14,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Text(
                      "₹ 24800",
                      style: AppTypography.poppinsMedium.copyWith(
                        fontSize: 14,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: kSize.height * 0.016),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Services Boys",
                      style: AppTypography.poppinsMedium.copyWith(
                        fontSize: 14,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Text(
                      "₹ 480000",
                      style: AppTypography.poppinsMedium.copyWith(
                        fontSize: 14,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: kSize.height * 0.032),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: AppTypography.poppinsMedium.copyWith(
                        fontSize: 18,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Text(
                      "₹ 4800000",
                      style: AppTypography.poppinsMedium.copyWith(
                        fontSize: 18,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              FooterButton(
                  label: 'Create Quote',
                  onTap: () {
                    //
                  }),
              SizedBox(
                height: kSize.height * 0.2,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget serviceRentalBtn() {
    return Row(
      children: [
        Flexible(
          child: FooterButton(
            fillColor: AppColors.transparent,
            label: 'Add Rental +',
            onTap: () {},
          ),
        ),
        const SizedBox(
          width: AppConstants.basePadding,
        ),
        Flexible(
          child: FooterButton(
            fillColor: AppColors.transparent,
            label: 'Add Service +',
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget eventTypeDropDown(Size kSize, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: kSize.height * 0.024),
      child: const CustomDropdownSearch(
        required: true,
        items: ["Wedding", "House Warming", "Nikkah", "Birthday", "Engagement"],
        label: AppStrings.eventTypeText,
        hintText: "Enter Event Type",
      ),
    );
  }

  Widget phoneField(Size kSize, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: kSize.height * 0.024),
      child: CustomTextField(
        required: true,
        text: AppStrings.phoneText,
        hintText: AppStrings.phoneHint,
        controller: TextEditingController(),
      ),
    );
  }

  Widget addressField(Size kSize, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: kSize.height * 0.024),
      child: CustomTextField(
        required: true,
        text: AppStrings.address,
        hintText: "Enter Address",
        controller: TextEditingController(),
      ),
    );
  }

  Widget eventVenueField(Size kSize, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: kSize.height * 0.024),
      child: CustomTextField(
        required: true,
        text: AppStrings.eventVenueText,
        hintText: "Enter Event Venue",
        controller: TextEditingController(),
      ),
    );
  }

  Widget customerNameField(Size kSize, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: kSize.height * 0.024),
      child: CustomTextField(
        required: true,
        text: AppStrings.customerName,
        hintText: "Enter Customer Name",
        controller: TextEditingController(),
      ),
    );
  }

  Widget quoteNo(Size kSize) {
    return Padding(
      padding: EdgeInsets.only(bottom: kSize.height * 0.024),
      child: Row(
        children: [
          Text(
            'Quote No.',
            style: AppTypography.poppinsMedium.copyWith(
              fontSize: 14,
              color: AppColors.secondaryColor.withOpacity(0.6),
            ),
          ),
          SizedBox(
            width: kSize.width * 0.1,
          ),
          Text(
            '#B0456',
            style: AppTypography.poppinsMedium.copyWith(
              fontSize: 14,
              color: AppColors.secondaryColor,
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
        AppStrings.quotation,
        style: AppTypography.poppinsSemiBold.copyWith(
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }
}
