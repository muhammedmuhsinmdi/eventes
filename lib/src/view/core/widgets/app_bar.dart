/* 


import 'package:flutter/material.dart';

import '../constants/constants.dart';

AppBar customAppBar({ String? label, Size? kSize, bool? isBackBtn, Widget? customLeading, } ) {
  return AppBar(
      elevation: 0,
      leading:    Padding(
        padding: const EdgeInsets.fromLTRB(AppConstants.basePadding, AppConstants.basePadding, 0, 0),
        child: IconButton(
            style: IconButton.styleFrom(),
            onPressed: () {
             
            },
            icon: SvgPicture.asset(
              AppImages.menu,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            )),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title:  Text(
        AppStrings.appHeaderText,
        style: AppTypography.poppinsSemiBold.copyWith(),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AppImages.notification,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ))
      ],
    )
} */