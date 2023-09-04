import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_strings.dart';
import 'employee_filter.dart';

class EmpHistoryFilter {
  BuildContext parentContext;
  EmpHistoryFilter(this.parentContext);

  Future show() async {
    final kSize = MediaQuery.of(parentContext).size;
    List<Widget> sortByJoinDate = [
      filterExpTile(kSize, FilterModel(label: 'Ascend', svg: AppImages.ascend)),
      filterExpTile(kSize, FilterModel(label: 'Descend', svg: AppImages.descend)),
      filterExpTile(
          kSize,
          FilterModel(
            label: 'None',
          ))
    ];
    List<Widget> positions = [
      filterExpTile(
          kSize,
          FilterModel(
            label: 'Supervisor',
          )),
      filterExpTile(
          kSize,
          FilterModel(
            label: "Head",
          )),
      filterExpTile(
          kSize,
          FilterModel(
            label: "Captain",
          )),
      filterExpTile(
          kSize,
          FilterModel(
            label: "Vice Captain",
          )),
      filterExpTile(
          kSize,
          FilterModel(
            label: "Main Boy",
          )),
      filterExpTile(
          kSize,
          FilterModel(
            label: " Boy",
          )),
      filterExpTile(
          kSize,
          FilterModel(
            label: "B Boy",
          ))
    ];
    await showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppConstants.basePadding),
                topRight: Radius.circular(AppConstants.basePadding))),
        backgroundColor: AppColors.accentDark,
        context: parentContext,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
                AppConstants.baseBorderRadius, AppConstants.baseBorderRadius, kSize.height * 0.024, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                header(context, kSize),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
                expansIonWidget(kSize: kSize, items: sortByJoinDate, title: 'Sort By Join Date'),
                expansIonWidget(kSize: kSize, items: sortByJoinDate, title: 'Sort By Pay'),
                expansIonWidget(kSize: kSize, items: positions, title: 'Position'),
                SizedBox(
                  height: kSize.height * 0.050,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FooterButton(
                      fillColor: AppColors.transparent,
                      width: kSize.width * 0.40,
                      label: "Reject",
                      onTap: () {
                        //
                      },
                    ),
                    FooterButton(
                      width: kSize.width * 0.40,
                      label: 'Hire',
                      onTap: () {
                        //
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
              ],
            ),
          );
        });
  }

  Widget header(BuildContext context, Size kSize) {
    return Row(
      children: [
        const Spacer(),
        Text(
          AppStrings.filterText,
          style: AppTypography.poppinsSemiBold.copyWith(
            fontSize: 18,
            color: AppColors.secondaryColor,
          ),
        ),
        const Spacer(),
        InkWell(
            highlightColor: AppColors.transparent,
            splashColor: AppColors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              AppStrings.clearText,
              style: AppTypography.poppinsMedium
                  .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6)),
            ))
      ],
    );
  }

  Widget filterExpTile(Size kSize, FilterModel filter) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primaryColor,
          )),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (filter.label != null)
            Text(
              filter.label!,
              style: AppTypography.poppinsRegular,
            ),
          if (filter.svg != null)
            SvgPicture.asset(
              filter.svg!,
              height: kSize.height * 0.02,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
        ],
      ),
    );
  }

  Widget expansIonWidget(
      {required Size kSize, required List<Widget> items, required String title, bool? isMultiSelect}) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(
        title,
        style: AppTypography.poppinsSemiBold.copyWith(
          color: AppColors.secondaryColor,
          fontSize: 18,
        ),
      ),
      childrenPadding: EdgeInsets.only(
        bottom: kSize.height * 0.024,
      ),
      children: [
        SizedBox(
          width: kSize.width,
          child: Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            // crossAxisAlignment: WrapCrossAlignment.start,
            children: List.generate(
                items.length,
                (index) => InkWell(
                    highlightColor: AppColors.transparent,
                    splashColor: AppColors.transparent,
                    onTap: () {
                      //
                      if (isMultiSelect != null && isMultiSelect) {
                      } else {}
                    },
                    child: items[index])),
          ),
        )
      ],
    );
  }
}
