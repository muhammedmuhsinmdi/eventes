import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/typography.dart';

class RequestTile extends StatelessWidget {
  const RequestTile({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(AppConstants.basePadding),
      width: kSize.width,
      clipBehavior: Clip.antiAlias,
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
          Row(
            children: [
              SvgPicture.asset(
                AppImages.warning,
                colorFilter: const ColorFilter.mode(AppColors.statusCritical, BlendMode.srcIn),
              ),
              SizedBox(
                width: kSize.width * 0.01,
              ),
              Text(
                "Double Work",
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
          RichText(
            text: TextSpan(
              text: 'Suhail H(A Boy) ',
              style: AppTypography.poppinsSemiBold.copyWith(fontSize: 14, color: AppColors.secondaryColor),
              children: [
                TextSpan(
                    text: 'has requested to join ',
                    style: AppTypography.poppinsLight
                        .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6))),
                TextSpan(
                  text: 'Marriage Function ',
                  style:
                      AppTypography.poppinsSemiBold.copyWith(fontSize: 14, color: AppColors.secondaryColor),
                ),
                TextSpan(
                    text: 'at ',
                    style: AppTypography.poppinsLight
                        .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6))),
                TextSpan(
                  text: 'Nova Auditorium ',
                  style:
                      AppTypography.poppinsSemiBold.copyWith(fontSize: 14, color: AppColors.secondaryColor),
                ),
                TextSpan(
                    text: 'on ',
                    style: AppTypography.poppinsLight
                        .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6))),
                TextSpan(
                  text: '23 Aug 2023 ',
                  style:
                      AppTypography.poppinsSemiBold.copyWith(fontSize: 14, color: AppColors.secondaryColor),
                ),
                TextSpan(
                    text: 'at ',
                    style: AppTypography.poppinsLight
                        .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6))),
                TextSpan(
                  text: '2:30PM ',
                  style:
                      AppTypography.poppinsSemiBold.copyWith(fontSize: 14, color: AppColors.secondaryColor),
                ),
                TextSpan(
                    text: 'to ',
                    style: AppTypography.poppinsLight
                        .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6))),
                TextSpan(
                  text: '9:00PM ',
                  style:
                      AppTypography.poppinsSemiBold.copyWith(fontSize: 14, color: AppColors.secondaryColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: kSize.height * 0.016, top: kSize.height * 0.02),
            child: RichText(
              text: TextSpan(
                text: 'He has already joined ',
                style: AppTypography.poppinsLight.copyWith(fontSize: 14, color: AppColors.secondaryColor),
                children: [
                  TextSpan(
                    text: 'Marriage Function ',
                    style:
                        AppTypography.poppinsSemiBold.copyWith(fontSize: 14, color: AppColors.secondaryColor),
                  ),
                  TextSpan(
                      text: 'at ',
                      style: AppTypography.poppinsLight
                          .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6))),
                  TextSpan(
                    text: 'Janatha Auditorium ',
                    style:
                        AppTypography.poppinsSemiBold.copyWith(fontSize: 14, color: AppColors.secondaryColor),
                  ),
                  TextSpan(
                      text: 'on ',
                      style: AppTypography.poppinsLight
                          .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6))),
                  TextSpan(
                    text: '23 Aug 2023 ',
                    style:
                        AppTypography.poppinsSemiBold.copyWith(fontSize: 14, color: AppColors.secondaryColor),
                  ),
                  TextSpan(
                      text: 'at ',
                      style: AppTypography.poppinsLight
                          .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6))),
                  TextSpan(
                    text: '10:30PM ',
                    style:
                        AppTypography.poppinsSemiBold.copyWith(fontSize: 14, color: AppColors.secondaryColor),
                  ),
                  TextSpan(
                      text: 'to ',
                      style: AppTypography.poppinsLight
                          .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6))),
                  TextSpan(
                    text: '2:00PM ',
                    style:
                        AppTypography.poppinsSemiBold.copyWith(fontSize: 14, color: AppColors.secondaryColor),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: SizedBox(
                  height: kSize.height * 0.04,
                  child: FooterButton(
                      padding: EdgeInsets.zero,
                      fillColor: AppColors.transparent,
                      label: 'Reject',
                      onTap: () {
                        // reject
                      }),
                ),
              ),
              SizedBox(
                width: kSize.width * 0.016,
              ),
              Flexible(
                child: SizedBox(
                  height: kSize.height * 0.04,
                  child: FooterButton(
                      padding: EdgeInsets.zero,
                      label: 'Approve',
                      onTap: () {
                        // Approve
                        Navigator.pushNamed(context, RouterConstants.boysSettleRoute);
                      }),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
