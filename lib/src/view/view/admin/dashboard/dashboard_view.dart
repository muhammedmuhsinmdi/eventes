import 'package:evantez/src/model/repository/auth/auth_controller.dart';
import 'package:evantez/src/model/repository/resource/employee_repository.dart';
import 'package:evantez/src/view/view/admin/dashboard/widgets/bottom_nav_bar.dart';
import 'package:evantez/src/view/view/admin/dashboard/events_view/events_view.dart';
import 'package:evantez/src/view/view/admin/transactions/payment/payment_view/payment_view.dart';
import 'package:evantez/src/view/view/admin/dashboard/profile_view/profile_view.dart';
import 'package:evantez/src/view/view/admin/dashboard/scan_qr_view/scan_qr_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../app/router/router_constant.dart';
import '../../../../model/core/enums/enum.dart';
import '../../../../model/core/models/menu/menu_model.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/constants.dart';
import '../../../core/themes/colors.dart';
import '../../../core/themes/typography.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final ValueNotifier<int> selectedScreen = ValueNotifier<int>(0);

  final PageStorageBucket pageBucket = PageStorageBucket();

  final screens = [
    EventsView(),
    const PaymentView(),
    const ProfileView(),
    const ScanQRView(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<EmployeesController>();
    final auth = context.watch<AuthController>();
    final kSize = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: selectedScreen,
        builder: (context, value, child) {
          return Scaffold(
            extendBody: true,
            appBar: selectedScreen.value == 0 ? appBar(context, kSize) : null,
            key: _key,
            drawerEnableOpenDragGesture: false,
            drawer: Drawer(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: SizedBox(
                height: kSize.height,
                width: kSize.width,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(kSize.width * 0.032,
                      kSize.height * 0.045, kSize.width * 0.032, 0),
                  child: Column(
                    children: [
                      Text(
                        'Menu',
                        style: AppTypography.poppinsSemiBold.copyWith(
                          color: AppColors.secondaryColor,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: kSize.height * 0.012,
                      ),
                      Expanded(
                        child: ListView(
                            children: MenuType.values.map((MenuType menuType) {
                          var menusBytype = menus
                              .where((e) => e.menuType == menuType)
                              .toList();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (menuType == MenuType.transaction) ...{
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: AppConstants.basePadding),
                                    child: Text(
                                      'Eve Dining',
                                      style:
                                          AppTypography.poppinsMedium.copyWith(
                                        color: AppColors.secondaryColor
                                            .withOpacity(0.4),
                                        fontSize: 14,
                                      ),
                                    )),
                              },
                              if (menuType == MenuType.catering) ...{
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: AppConstants.basePadding),
                                    child: Text(
                                      'Evantez Catering',
                                      style:
                                          AppTypography.poppinsMedium.copyWith(
                                        color: AppColors.secondaryColor
                                            .withOpacity(0.4),
                                        fontSize: 14,
                                      ),
                                    )),
                              },
                              ExpansionTile(
                                  initiallyExpanded: true,
                                  maintainState: true,
                                  iconColor: AppColors.primaryColor,
                                  collapsedIconColor: AppColors.secondaryColor,
                                  title: Text(
                                    menuType.name,
                                    textAlign: TextAlign.start,
                                    style: AppTypography.poppinsMedium.copyWith(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  childrenPadding: const EdgeInsets.symmetric(
                                      horizontal: AppConstants.basePadding),
                                  expandedCrossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  expandedAlignment: Alignment.centerLeft,
                                  children: menusBytype
                                      .map((e) => InkWell(
                                            highlightColor:
                                                AppColors.transparent,
                                            splashColor: AppColors.transparent,
                                            onTap: () async {
                                              if (e.routeUrl != null &&
                                                  e.routeUrl!.isNotEmpty) {
                                                _key.currentState!
                                                    .closeDrawer();
                                                Navigator.pushNamed(
                                                        context, e.routeUrl!,
                                                        arguments: e)
                                                    .then((value) {});
                                                controller.employeeList(
                                                    token:
                                                        auth.accesToken ?? '');

                                                controller.employeeTypesData(
                                                    token:
                                                        auth.accesToken ?? '');
                                              }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom:
                                                      AppConstants.marginSpace),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    e.menuName!,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  if (menusBytype.length !=
                                                      e.menuOrder)
                                                    Divider(
                                                      color: AppColors
                                                          .secondaryColor
                                                          .withOpacity(0.3),
                                                    )
                                                ],
                                              ),
                                            ),
                                          ))
                                      .toList()),
                            ],
                          );
                        }).toList()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SizedBox(
              height: kSize.height,
              width: kSize.width,
              child: PageStorage(
                bucket: pageBucket,
                child: screens[selectedScreen.value],
              ),
            ),
            bottomNavigationBar: DashBoardNaVBar(
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
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppConstants.basePadding, AppConstants.basePadding, 0, 0),
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
}
