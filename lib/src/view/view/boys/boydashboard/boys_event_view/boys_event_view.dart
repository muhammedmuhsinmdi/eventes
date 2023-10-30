import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/model/core/models/event_site/event_site_model.dart';
import 'package:evantez/src/serializer/models/event_site_model.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:evantez/src/view/core//widgets/custom_textfield.dart';
import 'package:evantez/src/view/view/admin/dashboard/events_view/widgets/event_tile.dart';
import 'package:evantez/src/view/core//widgets/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/themes/colors.dart';

class BoysEventView extends StatelessWidget {
  final bool? isBoy;
  BoysEventView({super.key, this.isBoy});
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: appBar(context, kSize),
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Column(
          children: [
            SizedBox(
              height: kSize.height * 0.032,
            ),
            tabBar(),
            SizedBox(
              height: kSize.height * 0.032,
            ),
            searchField(kSize),
            SizedBox(
              height: kSize.height * 0.014,
            ),
            eventsListing(kSize),
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context, Size kSize) {
    return AppBar(
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(AppConstants.basePadding, AppConstants.basePadding, 0, 0),
        child: IconButton(
            style: IconButton.styleFrom(),
            onPressed: () {
              _key.currentState!.openDrawer();
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
      title: Text(
        AppStrings.appHeaderText,
        style: AppTypography.poppinsSemiBold.copyWith(),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouterConstants.notificationRoute);
            },
            icon: SvgPicture.asset(
              AppImages.notification,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ))
      ],
    );
  }

  Widget tabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius),
      child: CustomTabBarView(
        tabItems: const ["Ongoing", "Upcoming", "Completed"],
        selectedTap: (tab) {
          // Tab selection
        },
      ),
    );
  }

  Widget searchField(Size kSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: CustomTextField(
              text: '',
              hintText: AppStrings.searchText,
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: SvgPicture.asset(
                  AppImages.search,
                  colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
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
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                ),
                onPressed: () {
                  //
                },
                child: SvgPicture.asset(
                  AppImages.filter,
                  colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                )),
          )
        ],
      ),
    );
  }

  Widget eventsListing(Size kSize) {
    return Expanded(
        child: ListView.separated(
            separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: kSize.height * 0.018),
                child: Divider(
                  color: AppColors.secondaryColor.withOpacity(0.1),
                ),
              );
            },
            itemCount: 10,
            padding: EdgeInsets.only(
                bottom: kSize.height * 0.16,
                left: AppConstants.baseBorderRadius,
                right: AppConstants.baseBorderRadius),
            itemBuilder: (context, index) {
              return InkWell(
                highlightColor: AppColors.transparent,
                splashColor: AppColors.transparent,
                onTap: () {
                  Navigator.pushNamed(context, RouterConstants.boyEventDetailRoute);
                },
                child: EventTile(
                  event: EventSiteModel(),
                  // eventList: [],
                  isBoy: true,
                  // i: index,
                  // itemCount: 10,
                ),
              );
            }));
  }
}
