import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/themes/colors.dart';

class PaymentTile extends StatelessWidget {
  const PaymentTile({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: kSize.height * 0.015),
      padding: EdgeInsets.all(kSize.height * 0.018),
      decoration: BoxDecoration(
          color: AppColors.accentDark,
          borderRadius: BorderRadius.circular(
            AppConstants.basePadding,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'EV-1568',
                style: AppTypography.poppinsMedium.copyWith(
                  color: AppColors.secondaryColor.withOpacity(0.4),
                  fontSize: 14,
                ),
              ),
              Text(
                '8 Nov 2023',
                style: AppTypography.poppinsMedium.copyWith(
                  color: AppColors.secondaryColor.withOpacity(0.4),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(
            height: kSize.height * 0.009,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sudheesh (A Boy)',
                style: AppTypography.poppinsMedium.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 14,
                ),
              ),
              Text(
                ' 2023', // Amount
                style: AppTypography.poppinsMedium.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(
            height: kSize.height * 0.009,
          ),
          Text(
            'EV-1568',
            style: AppTypography.poppinsMedium.copyWith(
              color: AppColors.secondaryColor.withOpacity(0.4),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
