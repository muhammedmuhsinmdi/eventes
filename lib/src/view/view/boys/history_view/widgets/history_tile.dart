import 'dart:developer';

import 'package:evantez/src/controller/resources/employee/employee_controller.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:evantez/src/view/core//widgets/custom_rating_star.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryTile extends StatelessWidget {
  const HistoryTile({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    final controller = context.watch<EmployeesController>();
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kSize.height * 0.018,
        vertical: kSize.height * 0.018,
      ),
      margin: EdgeInsets.only(bottom: kSize.height * 0.016),
      decoration: BoxDecoration(
          color: AppColors.accentDark,
          borderRadius: BorderRadius.circular(AppConstants.basePadding),
          border: Border.all(
            color: AppColors.accentColor,
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
            height: kSize.height * 0.01,
          ),
          CustomRatingStar(
            onRating: (value) {
              log('$value');
            },
            ignoreGestures: false,
            initialRating: 3,
          ),
          SizedBox(
            height: kSize.height * 0.01,
          ),
          labelRow(label: "Venue", value: 'HHHHHHHHHHH'),
          labelRow(label: "Category", value: 'A Boy'),
          labelRow(label: "Due", value: '₹ 1000'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              labelRow(label: "Payment", value: '₹ 5000'),
              paymentStatus(),
            ],
          ),
        ],
      ),
    );
  }

  Widget paymentStatus() {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.statusPending,
          borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(
        "Payment Pending",
        style: AppTypography.poppinsRegular.copyWith(
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }

  Widget labelRow({required String label, required String value}) {
    return RichText(
        text: TextSpan(
      text: "$label :  ",
      style: AppTypography.poppinsMedium.copyWith(
          color: AppColors.secondaryColor.withOpacity(
        0.4,
      )),
      children: [
        TextSpan(
            text: value,
            style: AppTypography.poppinsMedium.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 14,
            ))
      ],
    ));
  }
}
