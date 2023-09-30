import 'package:evantez/src/view/view/boys/boydashboard/boy_profile/boy_profile.dart';
import 'package:evantez/src/view/view/boys/boydashboard/widgets/boy_dash_board_nav.dart';
import 'package:evantez/src/view/view/boys/history_view/history_view.dart';
import 'package:evantez/src/view/view/admin/dashboard/scan_qr_view/scan_qr_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../app/router/router_constant.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/themes/colors.dart';
import '../../../core/themes/typography.dart';
import 'boys_event_view/boys_event_view.dart';

class BoyDashBoardView extends StatefulWidget {
  const BoyDashBoardView({super.key});

  @override
  State<BoyDashBoardView> createState() => _BoyDashBoardViewState();
}

class _BoyDashBoardViewState extends State<BoyDashBoardView> {
  final ValueNotifier<int> selectedScreen = ValueNotifier<int>(0);

  final PageStorageBucket pageBucket = PageStorageBucket();

  final screens = [
    BoysEventView(),
    const HistoryView(),
    const BoyProfileView(),
    const ScanQRView(),
  ];

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: selectedScreen,
        builder: (context, value, child) {
          return Scaffold(
            extendBody: true,
            appBar: selectedScreen.value == 0 ? appBar(context, kSize) : null,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SizedBox(
              height: kSize.height,
              width: kSize.width,
              child: PageStorage(
                bucket: pageBucket,
                child: screens[selectedScreen.value],
              ),
            ),
            bottomNavigationBar: BoyDashBoardNaVBar(
              selectedIndex: selectedScreen.value,
              onSelected: (screen) {
                selectedScreen.value = screen;
              },
            ),
          );
        });
  }

  AppBar appBar(BuildContext context, Size kSize) {
    return AppBar(
      elevation: 0,
      leading: const SizedBox(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        AppStrings.appHeaderText,
        style: AppTypography.poppinsSemiBold.copyWith(color: AppColors.secondaryColor),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouterConstants.boyNotificationRoute);
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
}
