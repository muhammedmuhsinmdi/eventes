import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:evantez/src/view/view/admin/dashboard/event_detail_view/widgets/add_employee_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/themes/typography.dart';

class EventOngoingSlot extends StatelessWidget {
  final String eventStatus;

  EventOngoingSlot({super.key, required this.eventStatus});

  final ValueNotifier<int> selectedCaptain = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getTitle(eventStatus),
            style: AppTypography.poppinsMedium.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: kSize.height * 0.032,
            width: kSize.height * 0.032,
            child: SvgPicture.asset(
              AppImages.arrowDown,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
      Column(
        children: List.generate(
            2,
            (index) => ValueListenableBuilder(
                valueListenable: selectedCaptain,
                builder: (context, value, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            index == 0 ? 'A Boy' : "Head",
                            style: AppTypography.poppinsMedium.copyWith(
                              color: AppColors.secondaryColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '3/5',
                            style: AppTypography.poppinsRegular.copyWith(
                              color: AppColors.secondaryColor.withOpacity(0.6),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: kSize.height * 0.008,
                      ),
                      Column(
                        children: List.generate(
                          3,
                          (value) => Container(
                            clipBehavior: Clip.antiAlias,
                            padding: EdgeInsets.symmetric(
                              horizontal: kSize.height * 0.01,
                              vertical: kSize.height * 0.01,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppConstants.basePadding),
                                border: Border.all(
                                    color: index == 0 && selectedCaptain.value == value
                                        ? AppColors.statusSuccess
                                        : AppColors.accentColor),
                                color: AppColors.accentDark),
                            margin: EdgeInsets.only(bottom: kSize.height * 0.016),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: kSize.width * 0.04,
                                  child: PopupMenuButton<String>(
                                    initialValue: 'make captain',
                                    // Callback that sets the selected popup menu item.
                                    onSelected: (item) {
                                      if (item == 'see profile') {
                                        Navigator.pushNamed(context, RouterConstants.empPerformanceRoute,
                                            arguments: eventStatus);
                                      }
                                      if (item == 'make captain') {}
                                    },
                                    clipBehavior: Clip.antiAlias,
                                    padding: EdgeInsets.zero, //symmetric(horizontal: kSize.height * 0.024),
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          color: AppColors.accentColor,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          AppConstants.basePadding,
                                        )),

                                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        onTap: () {
                                          selectedCaptain.value = value;
                                        },
                                        padding: EdgeInsets.symmetric(
                                          horizontal: kSize.width * 0.05,
                                        ),
                                        value: "make captain",
                                        child: Text(
                                          'Make Captain',
                                          textAlign: TextAlign.start,
                                          style: AppTypography.poppinsMedium.copyWith(),
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        onTap: () {
                                          //
                                        },
                                        padding: EdgeInsets.symmetric(
                                          horizontal: kSize.width * 0.05,
                                        ),
                                        value: "see profile",
                                        child: Text(
                                          'See Profile',
                                          textAlign: TextAlign.start,
                                          style: AppTypography.poppinsMedium.copyWith(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: kSize.width * 0.012,
                                ),
                                // const Spacer(),
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  height: kSize.height * 0.06,
                                  width: kSize.height * 0.06,
                                  child: const Placeholder(),
                                ),
                                SizedBox(
                                  width: kSize.width * 0.012,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Suhail',
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTypography.poppinsMedium.copyWith(
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: kSize.height * 0.004,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Head',
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTypography.poppinsRegular.copyWith(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          right: kSize.width * 0.02,
                                        ),
                                        height: kSize.height * 0.01,
                                        width: kSize.height * 0.01,
                                        decoration: BoxDecoration(
                                          color:
                                              index != 2 ? AppColors.statusSuccess : AppColors.statusCritical,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(
                                        height: kSize.height * 0.016,
                                      ),
                                      if (index == 0 && selectedCaptain.value == value)
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: kSize.width * 0.008,
                                              vertical: kSize.height * 0.002),
                                          decoration: BoxDecoration(
                                              color: AppColors.statusSuccess,
                                              borderRadius: BorderRadius.circular(
                                                AppConstants.basePadding,
                                              )),
                                          child: Text(
                                            'Captain',
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTypography.poppinsRegular.copyWith(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: kSize.height * 0.016,
                      ),
                    ],
                  );
                })),
      ),
      FooterButton(
        label: "Show Entry QR code",
        onTap: () {
          //
        },
      ),
      SizedBox(
        height: kSize.height * 0.024,
      ),
      FooterButton(
          fillColor: AppColors.transparent,
          label: "Add Employee",
          onTap: () {
            //
            AddEmployeeSheet(context).show();
          })
    ]);
  }
}

String getTitle(String eventStatus) {
  switch (eventStatus) {
    case "Upcoming - Hold" || "Upcoming - Open" || "Upcoming - Filled":
      return 'Slots';
    case "Ongoing" || "Settlement" || "Completed":
      return "Attendance";
    default:
      return '';
  }
}
