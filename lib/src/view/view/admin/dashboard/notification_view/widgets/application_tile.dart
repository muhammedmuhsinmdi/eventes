import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/themes/typography.dart';

class ApplicationTile extends StatelessWidget {
  final String requestType;
  const ApplicationTile({super.key, required this.requestType});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Container(
      width: kSize.width,
      padding: const EdgeInsets.all(AppConstants.basePadding),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.accentDark,
        borderRadius: BorderRadius.circular(
          AppConstants.basePadding,
        ),
        border: Border.all(color: AppColors.accentColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                requestType == "joining" ? AppImages.briefcase : AppImages.receipt,
                colorFilter: ColorFilter.mode(
                    requestType == "joining" ? AppColors.statusSuccess : AppColors.statusBlue,
                    BlendMode.srcIn),
              ),
              SizedBox(
                width: kSize.width * 0.01,
              ),
              Text(
                requestType == "joining" ? 'Joinee Request' : "New Customer Enquiry",
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
                    text: 'has submitted on application to join',
                    style: AppTypography.poppinsLight
                        .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6))),
              ],
            ),
          ),
          SizedBox(
            height: kSize.height * 0.01,
          ),
          SizedBox(
            height: kSize.height * 0.04,
            child: FooterButton(
                padding: EdgeInsets.zero,
                label: 'View',
                onTap: () {
                  //
                  Navigator.pushNamed(context, RouterConstants.empApplicationRoute);
                }),
          )
        ],
      ),
    );
  }
}
