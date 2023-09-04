import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/themes/colors.dart';

class NotificationTile extends StatelessWidget {
  final String paymentStatus;
  const NotificationTile({super.key, required this.paymentStatus});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Container(
      width: kSize.width,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(AppConstants.basePadding),
      decoration: BoxDecoration(
        color: AppColors.accentDark,
        borderRadius: BorderRadius.circular(
          AppConstants.basePadding,
        ),
        border: Border.all(color: AppColors.accentColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (paymentStatus == "Recieved") ...{
            Padding(
                padding: EdgeInsets.only(bottom: kSize.height * 0.008),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "EV-12332",
                      style:
                          AppTypography.poppinsMedium.copyWith(fontSize: 14, color: AppColors.secondaryColor),
                    ),
                    Text(
                      "1hr ago",
                      style: AppTypography.poppinsRegular
                          .copyWith(fontSize: 12, color: AppColors.secondaryColor),
                    )
                  ],
                )),
          },
          Row(
            children: [
              SvgPicture.asset(
                AppImages.coin,
                colorFilter: ColorFilter.mode(
                    paymentStatus == "Recieved" ? AppColors.statusSuccess : AppColors.statusWarning,
                    BlendMode.srcIn),
              ),
              SizedBox(
                width: kSize.width * 0.01,
              ),
              Text(
                paymentStatus == "Recieved" ? 'Payment Recieved' : "Amount Paid",
                style: AppTypography.poppinsMedium.copyWith(),
              )
            ],
          ),
          SizedBox(
            height: kSize.height * 0.01,
          ),
          Divider(
            color: AppColors.secondaryColor.withOpacity(0.3),
          ),
          SizedBox(
            height: kSize.height * 0.01,
          ),
          // A payment of 2654/-  From Soman has been received.
          RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                  text: 'A payment of ',
                  style: AppTypography.poppinsLight
                      .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6)),
                  children: [
                    TextSpan(
                        text: '2654/- ',
                        style: AppTypography.poppinsSemiBold.copyWith(
                          color: AppColors.secondaryColor,
                          fontSize: 14,
                        )),
                    TextSpan(
                        text: paymentStatus == "Received" ? 'From ' : 'For ',
                        style: AppTypography.poppinsLight.copyWith(
                          fontSize: 14,
                          color: AppColors.secondaryColor.withOpacity(0.6),
                        )),
                    TextSpan(
                        text: paymentStatus == "Recieved" ? 'Soman ' : 'Suhail ',
                        style: AppTypography.poppinsSemiBold.copyWith(
                          fontSize: 14,
                          color: AppColors.secondaryColor,
                        )),
                    TextSpan(
                        text: paymentStatus == "Recieved" ? 'has been received.' : 'has been paid.',
                        style: AppTypography.poppinsLight.copyWith(
                          fontSize: 14,
                          color: AppColors.secondaryColor.withOpacity(0.6),
                        )),
                  ])),
        ],
      ),
    );
  }
}
