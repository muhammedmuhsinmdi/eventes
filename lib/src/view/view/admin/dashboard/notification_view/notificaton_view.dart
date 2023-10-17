import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//widgets/custom_back_btn.dart';
import 'package:evantez/src/view/core//widgets/tab_bar.dart';
import 'package:evantez/src/view/view/admin/dashboard/notification_view/widgets/application_tile.dart';
import 'package:evantez/src/view/view/admin/dashboard/notification_view/widgets/notification_filter.dart';
import 'package:evantez/src/view/view/admin/dashboard/notification_view/widgets/notification_tile.dart';
import 'package:evantez/src/view/view/admin/dashboard/notification_view/widgets/request_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/typography.dart';
import '../../../../core/widgets/custom_textfield.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
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
              return Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppConstants.baseBorderRadius,
                    AppConstants.baseBorderRadius,
                    AppConstants.baseBorderRadius,
                    0),
                child: Column(children: [
                  // CustomTabBarView(
                  //     selectedTap: (value) {
                  //       //
                  //       selectedTab.value = value;
                  //     },
                  //     tabItems: const [
                  //       // AppStrings.paymentText,
                  //       // AppStrings.requestText,
                  //       // AppStrings.applicationText
                  //     ]),
                  searchField(kSize, context),
                  if (selectedTab.value == 0)
                    paymentNotificationListing(kSize, context),
                  if (selectedTab.value == 1) requestingListing(kSize, context),
                  if (selectedTab.value == 2)
                    applicationListing(kSize, context),
                ]),
              );
            }),
      ),
    );
  }

  Widget applicationListing(Size kSize, BuildContext context) {
    return Expanded(
        child: ListView.separated(
            padding: EdgeInsets.only(bottom: kSize.height * 0.032),
            separatorBuilder: (context, index) {
              return SizedBox(
                height: kSize.height * 0.016,
              );
            },
            itemCount: 2,
            itemBuilder: (context, index) {
              return ApplicationTile(
                requestType: index % 2 == 0 ? "joining" : "enquiry",
              );
            }));
  }

  Widget requestingListing(Size kSize, BuildContext context) {
    return Expanded(
        child: ListView.separated(
            padding: EdgeInsets.only(bottom: kSize.height * 0.032),
            separatorBuilder: (context, index) {
              return SizedBox(
                height: kSize.height * 0.016,
              );
            },
            itemCount: 10,
            itemBuilder: (context, index) {
              return const RequestTile();
            }));
  }

  Widget paymentNotificationListing(Size kSize, BuildContext context) {
    return Expanded(
        child: ListView.separated(
            padding: EdgeInsets.only(bottom: kSize.height * 0.032),
            separatorBuilder: (context, index) {
              return SizedBox(
                height: kSize.height * 0.016,
              );
            },
            itemCount: 10,
            itemBuilder: (context, index) {
              return NotificationTile(
                  paymentStatus: index % 2 == 0 ? "Recieved" : "Paid");
            }));
  }

  Widget searchField(Size kSize, BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: AppConstants.baseBorderRadius),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: CustomTextField(
              text: '',
              hintText: AppStrings.searchText,
              suffixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: SvgPicture.asset(
                  AppImages.search,
                  colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor, BlendMode.srcIn),
                ),
              ),
            ),
          ),
          SizedBox(
            width: kSize.width * 0.032,
          ),
          SizedBox(
            width: kSize.width * 0.1,
            child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.transparent,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 8.0),
                ),
                onPressed: () {
                  //
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(AppConstants.basePadding),
                              topRight:
                                  Radius.circular(AppConstants.basePadding))),
                      backgroundColor: AppColors.accentDark,
                      builder: (context) {
                        return NotificationFilter();
                      });
                },
                child: SvgPicture.asset(
                  AppImages.filter,
                  colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor, BlendMode.srcIn),
                )),
          )
        ],
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
        AppStrings.notificationText,
        style: AppTypography.poppinsSemiBold.copyWith(
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }
}
