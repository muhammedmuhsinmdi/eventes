import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../app/router/router_constant.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/constants.dart';
import '../../../core/themes/colors.dart';
import '../../../core/themes/typography.dart';
import '../../../core/widgets/custom_back_btn.dart';
import '../../../core/widgets/footer_button.dart';

class QuotationDetailView extends StatelessWidget {
  const QuotationDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, kSize),
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              AppConstants.baseBorderRadius, kSize.height * 0.032, AppConstants.baseBorderRadius, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                quotationStatus(kSize),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    AppStrings.customerName,
                    // 'Customer Name',
                    style: AppTypography.poppinsMedium.copyWith(
                      fontSize: 14,
                      color: AppColors.secondaryColor.withOpacity(0.6),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: kSize.height * 0.016),
                  child: Text(
                    'Kurian Thomas',
                    style: AppTypography.poppinsMedium.copyWith(
                      fontSize: 14,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    AppStrings.eventVenueText,
                    // 'Event Venue',
                    style: AppTypography.poppinsMedium.copyWith(
                      fontSize: 14,
                      color: AppColors.secondaryColor.withOpacity(0.6),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: kSize.height * 0.016),
                  child: Text(
                    'Janatha Auditorium, Palazhi',
                    style: AppTypography.poppinsMedium.copyWith(
                      fontSize: 14,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    AppStrings.eventTypeText,
                    // 'Event Type',
                    style: AppTypography.poppinsMedium.copyWith(
                      fontSize: 14,
                      color: AppColors.secondaryColor.withOpacity(0.6),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: kSize.height * 0.016),
                  child: Text(
                    'Wedding',
                    style: AppTypography.poppinsMedium.copyWith(
                      fontSize: 14,
                      color: AppColors.secondaryColor,
                    ),
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
                Padding(
                  padding: EdgeInsets.only(bottom: kSize.height * 0.016),
                  child: Text(
                    'Pallikkal House.\nKondotty PO 676085,\nMalappuram',
                    style: AppTypography.poppinsMedium.copyWith(
                      fontSize: 14,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    AppStrings.phoneText,
                    style: AppTypography.poppinsMedium.copyWith(
                      fontSize: 14,
                      color: AppColors.secondaryColor.withOpacity(0.6),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: kSize.height * 0.016),
                  child: Text(
                    '+9199999999999',
                    style: AppTypography.poppinsMedium.copyWith(
                      fontSize: 14,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kSize.height * 0.016),
                  child: Divider(
                    color: AppColors.secondaryColor.withOpacity(0.3),
                  ),
                ),
                Text(
                  'Rental Services',
                  style: AppTypography.poppinsSemiBold.copyWith(
                    fontSize: 18,
                    color: AppColors.secondaryColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kSize.height * 0.016),
                  child: listingTrail(['Table', 'Chair', 'Vessels', 'Glassware']),
                ),
                Text(
                  'Service Boys',
                  style: AppTypography.poppinsSemiBold.copyWith(
                    fontSize: 18,
                    color: AppColors.secondaryColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kSize.height * 0.016),
                  child: listingTrail(["Head", 'Captain', "A Boys", 'Fresh Boys']),
                ),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                Text(
                  "Summary",
                  style: AppTypography.poppinsSemiBold.copyWith(
                    fontSize: 18,
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(height: kSize.height * 0.016),
                // total(),

                SizedBox(
                  height: kSize.height * 0.016,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rentals',
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
                ),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Man powers',
                      style: AppTypography.poppinsMedium.copyWith(
                        fontSize: 14,
                        color: AppColors.secondaryColor.withOpacity(0.6),
                      ),
                    ),
                    Text(
                      '₹ 517778',
                      style: AppTypography.poppinsMedium.copyWith(
                        fontSize: 14,
                        color: AppColors.secondaryColor,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: AppTypography.poppinsMedium.copyWith(
                        fontSize: 18,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Text(
                      '₹ 5177789',
                      style: AppTypography.poppinsMedium.copyWith(
                        fontSize: 18,
                        color: AppColors.secondaryColor,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: kSize.height * 0.04,
                ),
                FooterButton(
                  label: 'Create Event',
                  onTap: () {
                    //
                  },
                ),
                SizedBox(height: kSize.height * 0.032),
                FooterButton(
                  fillColor: AppColors.transparent,
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

  Widget quotationStatus(Size kSize) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kSize.height * 0.012, vertical: kSize.height * 0.006),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.secondaryColor.withOpacity(0.4)),
          color: AppColors.statusSuccess,
          borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius)),
      child: Text(
        'Approved',
        style: AppTypography.poppinsMedium.copyWith(
          color: AppColors.secondaryColor,
          fontSize: 12,
        ),
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
        AppStrings.quotations,
        style: AppTypography.poppinsSemiBold.copyWith(
          color: AppColors.secondaryColor,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            //
            Navigator.pushNamed(context, RouterConstants.newQuotationRoute);
          },
          icon: SvgPicture.asset(
            AppImages.edit,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
        )
      ],
    );
  }
}
