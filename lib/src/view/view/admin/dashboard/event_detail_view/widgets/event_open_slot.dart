import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EventOpenSlot extends StatelessWidget {
  final String eventStatus;
  const EventOpenSlot({super.key, required this.eventStatus});

  @override
  Widget build(BuildContext context) {
    int itemCount = 50;
    final kSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        SizedBox(
          height: kSize.height * 0.016,
        ),
        Column(
          children: List.generate(
              2,
              (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'A Boy',
                        style: AppTypography.poppinsMedium.copyWith(
                          color: AppColors.secondaryColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: kSize.height * 0.008,
                      ),
                      Wrap(
                        runSpacing: 8,
                        spacing: 8,
                        children: List.generate(
                            itemCount,
                            (index) => IntrinsicWidth(
                                    child: Container(
                                  height: kSize.height * 0.005,
                                  width: getCountWidth(itemCount),
                                  decoration: BoxDecoration(
                                    color: index < 3 ? AppColors.statusSuccess : AppColors.statusCritical,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ))),
                      ),
                      SizedBox(
                        height: kSize.height * 0.016,
                      ),
                      Text(
                        '3/$itemCount',
                        style: AppTypography.poppinsRegular.copyWith(
                          color: AppColors.secondaryColor.withOpacity(0.6),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: kSize.height * 0.016,
                      )
                    ],
                  )),
        )
      ],
    );
  }

  double getCountWidth(int itemCount) {
    if (itemCount <= 5) {
      return 66;
    } else if (itemCount <= 10) {
      return 33;
    } else if (itemCount <= 20) {
      return 22;
    } else if (itemCount <= 30) {
      return 11;
    } else {
      return 5;
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
}
