import 'package:evantez/src/view/core//constants/app_strings.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/widgets/custom_back_btn.dart';
import '../../../../core/widgets/footer_button.dart';

class InvoiceDetailView extends StatelessWidget {
  const InvoiceDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, kSize),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                Text(
                  'Invoice No.',
                  style: AppTypography.poppinsMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.secondaryColor.withOpacity(0.6),
                  ),
                ),
                Text(
                  '#B0456',
                  style: AppTypography.poppinsMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                Text(
                  'Invoice Date',
                  style: AppTypography.poppinsMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.secondaryColor.withOpacity(0.6),
                  ),
                ),
                Text(
                  '03 Nov, 2023',
                  style: AppTypography.poppinsMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                Text(
                  'Event Code',
                  style: AppTypography.poppinsMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.secondaryColor.withOpacity(0.6),
                  ),
                ),
                Text(
                  'EV-0202',
                  style: AppTypography.poppinsMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                Text(
                  'Event Type',
                  style: AppTypography.poppinsMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.secondaryColor.withOpacity(0.6),
                  ),
                ),
                Text(
                  'Wedding',
                  style: AppTypography.poppinsMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                Text(
                  'Customer Name',
                  style: AppTypography.poppinsMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.secondaryColor.withOpacity(0.6),
                  ),
                ),
                Text(
                  'Muhammed Roshan',
                  style: AppTypography.poppinsMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                Text(
                  'Event Venue',
                  style: AppTypography.poppinsMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.secondaryColor.withOpacity(0.6),
                  ),
                ),
                Text(
                  'Janata Auditorium, Palazhi',
                  style: AppTypography.poppinsMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                Text(
                  'Address',
                  style: AppTypography.poppinsMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.secondaryColor.withOpacity(0.6),
                  ),
                ),
                Text(
                  'Pallikkal House.\nKondotty PO\n676085, Malappuram',
                  maxLines: 3,
                  style: AppTypography.poppinsMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                Text(
                  'Phone',
                  style: AppTypography.poppinsMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.secondaryColor.withOpacity(0.6),
                  ),
                ),
                Text(
                  '+91 99999999999',
                  style: AppTypography.poppinsMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                Divider(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                ),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                Text(
                  'Rental Services',
                  style: AppTypography.poppinsSemiBold.copyWith(
                    fontSize: 18,
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                listingTrail(['Table', 'Chair', 'Vessels', 'Glassware']),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                Divider(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                ),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                Text(
                  'Service Boys',
                  style: AppTypography.poppinsSemiBold.copyWith(
                    fontSize: 18,
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                listingTrail(["Head", 'Captain', "A Boys", 'Fresh Boys']),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                Text(
                  "Summary",
                  style: AppTypography.poppinsSemiBold.copyWith(
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: kSize.height * 0.016),
                total(),
                SizedBox(height: kSize.height * 0.016),
                summaryListing(['Setting Work', "Service Boys"]),
                SizedBox(height: kSize.height * 0.016),
                grandTotal(),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                Divider(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                ),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                paidAmount(),
                SizedBox(height: kSize.height * 0.016),
                balance(),
                SizedBox(height: kSize.height * 0.032),
                FooterButton(
                  label: 'Share',
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

  Widget paidAmount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Paid Amount',
          style: AppTypography.poppinsMedium.copyWith(
            fontSize: 14,
            color: AppColors.secondaryColor.withOpacity(0.6),
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

  Widget summaryListing(List<String> items) {
    return Column(
        children: List.generate(
      items.length,
      (index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                items[index],
                style: AppTypography.poppinsMedium.copyWith(
                  fontSize: 14,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
            Text(
              '548',
              style: AppTypography.poppinsMedium.copyWith(
                fontSize: 14,
                color: AppColors.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget total() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total',
          style: AppTypography.poppinsSemiBold.copyWith(
            fontSize: 18,
            color: AppColors.secondaryColor,
          ),
        ),
        Text(
          '₹ 4116666',
          style: AppTypography.poppinsSemiBold.copyWith(
            fontSize: 18,
            color: AppColors.secondaryColor,
          ),
        )
      ],
    );
  }

  Widget grandTotal() {
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
          '₹ 5216666',
          style: AppTypography.poppinsSemiBold.copyWith(
            fontSize: 24,
            color: AppColors.secondaryColor,
          ),
        )
      ],
    );
  }

  Widget listingTrail(List<String> items) {
    return Column(
      children: List.generate(
          items.length,
          (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        items[index],
                        style: AppTypography.poppinsMedium.copyWith(
                          fontSize: 14,
                          color: AppColors.secondaryColor.withOpacity(0.6),
                        ),
                      ),
                    ),
                    Text(
                      '5',
                      style: AppTypography.poppinsMedium.copyWith(
                        fontSize: 14,
                        color: AppColors.secondaryColor.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(
                      width: AppConstants.baseBorderRadius,
                    ),
                    Text(
                      '548',
                      style: AppTypography.poppinsMedium.copyWith(
                        fontSize: 14,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ],
                ),
              )),
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
      actions: [
        IconButton(
            onPressed: () {
              //
            },
            icon: SvgPicture.asset(
              AppImages.edit,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ))
      ],
    );
  }
}
