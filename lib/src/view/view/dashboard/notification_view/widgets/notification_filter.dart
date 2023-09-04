import 'dart:developer';

import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:evantez/src/view/view/dashboard/notification_view/widgets/selected_emp_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/typography.dart';
import '../../../resouces/employee/employee_list_view/widgets/employee_filter.dart';

class NotificationFilter extends StatelessWidget {
  NotificationFilter({super.key});

  final List<FilterModel> orderList = [
    FilterModel(label: 'Ascend', svg: AppImages.ascend),
    FilterModel(label: 'Descend', svg: AppImages.descend),
    FilterModel(label: 'None')
  ];

  final ValueNotifier<String> selecteddate = ValueNotifier<String>('');

  final ValueNotifier<List<String>> selectEmp = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppConstants.baseBorderRadius, AppConstants.baseBorderRadius,
            AppConstants.baseBorderRadius, AppConstants.largePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(context, kSize),
            SizedBox(
              height: kSize.height * 0.024,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.basePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.sortByJoinDate,
                    style: AppTypography.poppinsSemiBold.copyWith(
                      color: AppColors.secondaryColor,
                      fontSize: 18,
                    ),
                  ),
                  SvgPicture.asset(
                    AppImages.arrowDown,
                    colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
                valueListenable: selecteddate,
                builder: (context, value, child) {
                  return Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                        3,
                        (index) => InkWell(
                              highlightColor: AppColors.transparent,
                              splashColor: AppColors.transparent,
                              onTap: () {
                                //
                                selecteddate.value = orderList[index].label!;
                              },
                              child: filterExpTile(
                                kSize,
                                orderList[index],
                              ),
                            )),
                  );
                }),
            SizedBox(
              height: kSize.height * 0.024,
            ),
            Divider(
              color: AppColors.secondaryColor.withOpacity(0.3),
            ),
            SizedBox(
              height: kSize.height * 0.024,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.basePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.employeeCategoryText,
                    style: AppTypography.poppinsSemiBold.copyWith(
                      color: AppColors.secondaryColor,
                      fontSize: 18,
                    ),
                  ),
                  SvgPicture.asset(
                    AppImages.arrowDown,
                    colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
                valueListenable: selectEmp,
                builder: (context, value, child) {
                  return SelectEmpList(
                    onSelectedList: (empList) {
                      selectEmp.value = empList;
                      log("${selectEmp.value}");
                    },
                  );
                }),
            SizedBox(
              height: kSize.height * 0.048,
            ),
            Row(
              children: [
                Flexible(
                    child: FooterButton(
                        fillColor: AppColors.transparent,
                        label: "Cancel",
                        onTap: () {
                          //
                          Navigator.pop(context);
                        })),
                SizedBox(
                  width: kSize.width * 0.016,
                ),
                Flexible(
                    child: FooterButton(
                        label: "Update",
                        onTap: () {
                          //
                        }))
              ],
            )
          ],
        ),
      ),
    );
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
      // margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: selecteddate.value == filter.label ? AppColors.primaryColor : AppColors.transparent,
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
              style: AppTypography.poppinsRegular.copyWith(color: AppColors.secondaryColor, fontSize: 12),
            ),
          if (filter.svg != null)
            Padding(
              padding: filter.svg == AppImages.star ? const EdgeInsets.only(right: 12) : EdgeInsets.zero,
              child: SvgPicture.asset(
                filter.svg!,
                height: kSize.height * 0.02,
                colorFilter: const ColorFilter.mode(
                  AppColors.secondaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
