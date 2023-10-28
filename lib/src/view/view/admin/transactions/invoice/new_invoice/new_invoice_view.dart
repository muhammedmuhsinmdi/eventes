import 'package:evantez/src/view/core//constants/app_strings.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:evantez/src/view/core//widgets/custom_back_btn.dart';
import 'package:evantez/src/view/core//widgets/custom_date_picker.dart';
import 'package:evantez/src/view/core//widgets/custom_dropdown_search.dart';
import 'package:evantez/src/view/core//widgets/custom_textfield.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:evantez/src/view/view/admin/transactions/new_event/widgets/custom_service_counter.dart';
import 'package:flutter/material.dart';

class NewInvoiceView extends StatelessWidget {
  const NewInvoiceView({super.key});

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
          padding: const EdgeInsets.fromLTRB(
              AppConstants.baseBorderRadius, AppConstants.baseBorderRadius, AppConstants.baseBorderRadius, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                invoiceNo(),
                SizedBox(height: kSize.height * 0.024),
                invoiceDate(),
                SizedBox(height: kSize.height * 0.024),
                Divider(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                ),
                SizedBox(height: kSize.height * 0.024),
                const CustomDropdownSearch(
                  label: AppStrings.eventCodeText,
                  items: [
                    "EV-0202 - Wedding - Orange...",
                    "EV-0203 - Wedding - Shifa...",
                    "EV-0204 - Wedding - Nazra...",
                    "EV-0205 - Wedding - Nassan...",
                  ],
                  hintText: 'Select Event Code',
                ),
                SizedBox(height: kSize.height * 0.024),
                Divider(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                ),
                SizedBox(height: kSize.height * 0.024),
                Text(
                  'Customer Information',
                  style: AppTypography.poppinsSemiBold.copyWith(
                    fontSize: 16,
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(height: kSize.height * 0.024),
                const CustomDropdownSearch(
                  label: AppStrings.customerName,
                  hintText: 'Enter Customer Name',
                  items: ['Orange - Kotakkal', "Shifa - Manjeri", 'Palacio - Malappuram'],
                ),
                SizedBox(height: kSize.height * 0.024),
                const CustomDropdownSearch(
                  label: 'Event Venue',
                  hintText: 'Enter Event Venue',
                  items: ['Janata Auditorium, Palazhi', "VP Hall, Manjeri", 'Nassan , Irumbuzhi'],
                ),
                SizedBox(height: kSize.height * 0.024),
                const CustomDropdownSearch(
                  label: 'Event Type',
                  hintText: 'Enter Event Type',
                  items: ['Wedding', "House Warming", 'Nikhah', 'Birthday'],
                ),
                SizedBox(height: kSize.height * 0.024),
                CustomTextField(
                  text: AppStrings.address,
                  maxLines: 3,
                  hintText: 'Enter Address',
                  controller: TextEditingController(),
                ),
                SizedBox(height: kSize.height * 0.024),
                CustomTextField(
                  text: AppStrings.phoneText,
                  hintText: 'Enter Phone',
                  controller: TextEditingController(),
                ),
                SizedBox(height: kSize.height * 0.024),
                Divider(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                ),
                SizedBox(height: kSize.height * 0.024),
                settingWork(kSize, context),
                SizedBox(height: kSize.height * 0.024),
                serviceBoys(kSize, context),
                SizedBox(height: kSize.height * 0.024),
                Divider(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                ),
                SizedBox(height: kSize.height * 0.024),
                Text(
                  "Summary",
                  style: AppTypography.poppinsSemiBold.copyWith(
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: kSize.height * 0.032),
                manPower(),
                SizedBox(height: kSize.height * 0.016),
                subTotal(),
                SizedBox(height: kSize.height * 0.016),
                Divider(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                ),
                SizedBox(height: kSize.height * 0.016),
                discount(kSize),
                SizedBox(height: kSize.height * 0.016),
                Divider(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                ),
                SizedBox(height: kSize.height * 0.016),
                total(),
                SizedBox(height: kSize.height * 0.016),
                Divider(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                ),
                SizedBox(height: kSize.height * 0.016),
                paidAmount(),
                SizedBox(height: kSize.height * 0.016),
                balance(),
                SizedBox(height: kSize.height * 0.032),
                FooterButton(
                  label: 'Create Invoice',
                  onTap: () {
                    //
                  },
                ),
                SizedBox(height: kSize.height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget total() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total',
          style: AppTypography.poppinsSemiBold.copyWith(
            fontSize: 24,
            color: AppColors.secondaryColor,
          ),
        ),
        Text(
          '₹ 51777',
          style: AppTypography.poppinsSemiBold.copyWith(
            fontSize: 24,
            color: AppColors.secondaryColor,
          ),
        )
      ],
    );
  }

  Widget discount(Size kSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Discount',
          style: AppTypography.poppinsSemiBold.copyWith(
            fontSize: 18,
            color: AppColors.secondaryColor,
          ),
        ),
        SizedBox(
            width: kSize.width * 0.25,
            child: const CustomTextField(
              text: '',
              keyboardType: TextInputType.number,
            ))
      ],
    );
  }

  Widget settingWork(Size kSize, BuildContext context) {
    return ExpansionTile(
      maintainState: true,
      childrenPadding: EdgeInsets.symmetric(vertical: kSize.height * 0.024),
      iconColor: AppColors.primaryColor,
      collapsedIconColor: AppColors.secondaryColor,
      tilePadding: EdgeInsets.zero,
      title: Text(
        'Setting Work',
        style: AppTypography.poppinsSemiBold.copyWith(
          fontSize: 16,
          color: AppColors.secondaryColor,
        ),
      ),
      children: [
        Column(
          children: List.generate(
              2,
              (index) => const CustomServiceCounter(
                    items: [
                      /*   'Table Setting',
                      "Plate Washing",
                      'Stage work' */
                    ],
                    label: 'Select Setting work ',
                  )),
        ),
        SizedBox(height: kSize.height * 0.024),
        FooterButton(
            fillColor: AppColors.transparent,
            label: 'Add +',
            onTap: () {
              //
            }),
      ],
    );
  }

  Widget serviceBoys(Size kSize, BuildContext context) {
    return ExpansionTile(
      maintainState: true,
      childrenPadding: EdgeInsets.symmetric(vertical: kSize.height * 0.024),
      iconColor: AppColors.primaryColor,
      collapsedIconColor: AppColors.secondaryColor,
      tilePadding: EdgeInsets.zero,
      title: Text(
        'Service Boys',
        style: AppTypography.poppinsSemiBold.copyWith(
          fontSize: 16,
          color: AppColors.secondaryColor,
        ),
      ),
      children: [
        Column(
          children: List.generate(
              2,
              (index) => const CustomServiceCounter(
                    items: [],
                    label: 'Service boys ',
                  )),
        ),
        SizedBox(height: kSize.height * 0.024),
        FooterButton(
            fillColor: AppColors.transparent,
            label: 'Add +',
            onTap: () {
              //
            }),
      ],
    );
  }

  Widget paidAmount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Paid Amount',
          style: AppTypography.poppinsMedium.copyWith(
            fontSize: 14,
            color: AppColors.secondaryColor,
          ),
        ),
        Text(
          '₹ 51777',
          style: AppTypography.poppinsMedium.copyWith(
            fontSize: 14,
            color: AppColors.secondaryColor,
          ),
        )
      ],
    );
  }

  Widget invoiceNo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Invoice No.',
          style: AppTypography.poppinsMedium.copyWith(
            fontSize: 14,
            color: AppColors.secondaryColor,
          ),
        ),
        Text(
          '#B0456',
          style: AppTypography.poppinsMedium.copyWith(
            fontSize: 14,
            color: AppColors.secondaryColor,
          ),
        )
      ],
    );
  }

  Widget manPower() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Manpower',
          style: AppTypography.poppinsMedium.copyWith(
            fontSize: 14,
            color: AppColors.secondaryColor,
          ),
        ),
        Text(
          '₹ 48784',
          style: AppTypography.poppinsMedium.copyWith(
            fontSize: 14,
            color: AppColors.secondaryColor,
          ),
        )
      ],
    );
  }

  Widget subTotal() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Subtotal',
          style: AppTypography.poppinsSemiBold.copyWith(
            fontSize: 18,
            color: AppColors.secondaryColor,
          ),
        ),
        Text(
          '₹ 51777',
          style: AppTypography.poppinsSemiBold.copyWith(
            fontSize: 18,
            color: AppColors.secondaryColor,
          ),
        )
      ],
    );
  }

  Widget balance() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Balance',
          style: AppTypography.poppinsSemiBold.copyWith(
            fontSize: 18,
            color: AppColors.secondaryColor,
          ),
        ),
        Text(
          '₹ 51777',
          style: AppTypography.poppinsSemiBold.copyWith(
            fontSize: 18,
            color: AppColors.secondaryColor,
          ),
        )
      ],
    );
  }

  Widget invoiceDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Invoice Date',
          style: AppTypography.poppinsMedium.copyWith(
            fontSize: 14,
            color: AppColors.secondaryColor,
          ),
        ),
        CustomDatePicker(
            // label: 'Date',
            fillColor: AppColors.transparent,
            controller: TextEditingController(text: '3333'),
            type: "Date",
            onChanged: (value) {
              //
            })
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
        AppStrings.invoiceText,
        style: AppTypography.poppinsSemiBold.copyWith(),
      ),
    );
  }
}
