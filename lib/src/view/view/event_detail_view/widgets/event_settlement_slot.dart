import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../app/router/router_constant.dart';
import '../../../core/constants/app_images.dart';

class EventSettleMentSlot extends StatelessWidget {
  final String eventStatus;

  const EventSettleMentSlot({super.key, required this.eventStatus});

  // final ValueNotifier<int> selectedCaptain = ValueNotifier<int>(-1);

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
            (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'A Boy',
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
                        2,
                        (index) => Container(
                          clipBehavior: Clip.antiAlias,
                          padding: EdgeInsets.symmetric(
                            horizontal: kSize.height * 0.01,
                            vertical: kSize.height * 0.01,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppConstants.basePadding),
                              border: Border.all(color: AppColors.accentColor),
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
                                        // selectedCaptain.value = index;
                                      },
                                      padding: EdgeInsets.symmetric(
                                        horizontal: kSize.width * 0.05,
                                      ),
                                      // value: "make captain",
                                      child: Text(
                                        'Make Captain',
                                        textAlign: TextAlign.start,
                                        style: AppTypography.poppinsMedium.copyWith(),
                                      ),
                                    ),
                                    PopupMenuItem<String>(
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
                )),
      ),
      SizedBox(
        height: kSize.height * 0.024,
      ),
      FooterButton(
          label: "Scan Settlement QR",
          onTap: () {
            //
          })
    ]);
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
}
