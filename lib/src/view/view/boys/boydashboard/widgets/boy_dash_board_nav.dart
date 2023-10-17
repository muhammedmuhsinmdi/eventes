import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BoyDashBoardNaVBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelected;
  BoyDashBoardNaVBar({super.key, required this.selectedIndex, required this.onSelected});

  final List<String> boysBottomNavIcons = [
    AppImages.calender,
    AppImages.history,
    AppImages.profileCircle,
    AppImages.scanBarCode,
  ];

  final List<String> boysBottomNavLabels = [
    "EVENTS",
    "HISTORY",
    "PROFILE",
    "SCAN QR",
  ];

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;

    return Container(
      // height: kSize.height * 0.124,
      width: kSize.width,
      padding: EdgeInsets.only(
          bottom: kSize.height * 0.032,
          right: kSize.width * 0.024,
          left: kSize.width * 0.024,
          top: kSize.height * 0.016),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.accentColor),
          color: AppColors.accentDark,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
            4,
            (index) => InkWell(
                  onTap: () {
                    onSelected(index);
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: selectedIndex == index
                            ? AppColors.secondaryColor.withOpacity(0.05)
                            : AppColors.transparent),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: kSize.height * 0.032,
                            width: kSize.height * 0.032,
                            child: SvgPicture.asset(
                              boysBottomNavIcons[index],
                              colorFilter: ColorFilter.mode(
                                  selectedIndex == index ? AppColors.primaryColor : AppColors.secondaryColor,
                                  BlendMode.srcIn),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: kSize.height * 0.004, top: kSize.height * 0.004),
                            child: Text(
                              boysBottomNavLabels[index],
                              style: AppTypography.poppinsMedium
                                  .copyWith(color: AppColors.secondaryColor, fontSize: 12),
                            ),
                          ),
                          Container(
                            height: kSize.height * 0.006,
                            width: kSize.height * 0.006,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    selectedIndex == index ? AppColors.primaryColor : AppColors.transparent),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}
