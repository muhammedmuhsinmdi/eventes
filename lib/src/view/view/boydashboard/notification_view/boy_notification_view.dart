import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//widgets/custom_back_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/themes/colors.dart';
import '../../../core/themes/typography.dart';

class BoyNotificationView extends StatefulWidget {
  const BoyNotificationView({super.key});

  @override
  State<BoyNotificationView> createState() => _BoyNotificationViewState();
}

class _BoyNotificationViewState extends State<BoyNotificationView> {
  final ValueNotifier<int> selectedTab = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, kSize),
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: ValueListenableBuilder(
            valueListenable: selectedTab,
            builder: (context, value, child) {
              return ListView.separated(
                  padding: EdgeInsets.fromLTRB(
                      AppConstants.baseBorderRadius, 0, AppConstants.baseBorderRadius, kSize.height * 0.032),
                  itemBuilder: (context, index) {
                    return notificationTile(kSize, index);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: kSize.height * 0.016,
                    );
                  },
                  itemCount: 3);
            }),
      ),
    );
  }

  Widget notificationTile(Size kSize, int index) {
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
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "EV-12332",
                  style: AppTypography.poppinsMedium.copyWith(fontSize: 14, color: AppColors.secondaryColor),
                ),
                Text(
                  "1hr ago",
                  style: AppTypography.poppinsRegular.copyWith(fontSize: 12, color: AppColors.secondaryColor),
                )
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SvgPicture.asset(
                  index == 0
                      ? AppImages.tasksquare
                      : index == 1
                          ? AppImages.clock
                          : AppImages.warning,
                  height: kSize.height * 0.028,
                  colorFilter: ColorFilter.mode(
                      index == 0
                          ? AppColors.secondaryColor.withOpacity(0.8)
                          : index == 1
                              ? AppColors.statusWarning
                              : AppColors.statusCritical,
                      BlendMode.srcIn),
                ),
              ),
              Text(
                index == 0
                    ? "Settings work assigned"
                    : index == 1
                        ? "Event Reminder"
                        : "Urgent!",
                style: AppTypography.poppinsSemiBold.copyWith(color: AppColors.secondaryColor, fontSize: 18),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppConstants.baseTextFieldBorderRdious),
            child: Divider(
              color: AppColors.secondaryColor.withOpacity(0.3),
            ),
          ),
          if (index == 0) assignedDesc(),
          if (index == 1) eventReminderDesc(),
          if (index == 2) urgentDesc(),
          if (index == 2) callBtn(kSize),
        ],
      ),
    );
  }

  Widget callBtn(Size kSize) {
    return SizedBox(
      width: kSize.width,
      child: Padding(
        padding: const EdgeInsets.only(top: AppConstants.baseBorderRadius),
        child: TextButton(
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius)),
                backgroundColor: AppColors.primaryColor),
            onPressed: () {
              //
            },
            child: Text(
              'Apply',
              style: AppTypography.poppinsMedium.copyWith(),
            )),
      ),
    );
  }

  Widget urgentDesc() {
    return Text(
      "10 A boys needed near Crown theater in half hour. call 91123123132",
      style: AppTypography.poppinsLight.copyWith(
        color: AppColors.secondaryColor,
        fontSize: 16,
      ),
    );
  }

  Widget eventReminderDesc() {
    return RichText(
        text: TextSpan(
            text: 'Marriage function ',
            style: AppTypography.poppinsSemiBold
                .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6)),
            children: [
          TextSpan(
            text: 'at ',
            style: AppTypography.poppinsLight.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 14,
            ),
          ),
          TextSpan(
              text: 'Marriage function ',
              style: AppTypography.poppinsSemiBold
                  .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6))),
          TextSpan(
            text: 'at ',
            style: AppTypography.poppinsLight.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 14,
            ),
          ),
          TextSpan(
              text: '02:30PM to 11:00PM ',
              style: AppTypography.poppinsSemiBold
                  .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6))),
          TextSpan(
            text: 'is ',
            style: AppTypography.poppinsLight.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 14,
            ),
          ),
          TextSpan(
              text: 'tomorrow. ',
              style: AppTypography.poppinsSemiBold
                  .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6))),
          TextSpan(
            text: 'Please be prepared ',
            style: AppTypography.poppinsLight.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 14,
            ),
          ),
        ]));
  }

  Widget assignedDesc() {
    return RichText(
        text: TextSpan(
            text: 'You were assigned an Setting Work - ',
            style: AppTypography.poppinsRegular
                .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6)),
            children: [
          TextSpan(
              text: 'Serve Tables.',
              style: AppTypography.poppinsSemiBold.copyWith(
                color: AppColors.secondaryColor,
                fontSize: 14,
              ))
        ]));
  }

  AppBar appBar(BuildContext context, Size kSize) {
    return AppBar(
      elevation: 0,
      leading: const CustomBackButton(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        AppStrings.notificationText,
        style: AppTypography.poppinsSemiBold.copyWith(
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }
}
