import 'package:evantez/src/view/view/resouces/employee/employee_list_view/widgets/selection_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/themes/typography.dart';
import '../../../../../core/widgets/footer_button.dart';
import '../../../../dashboard/notification_view/widgets/selected_emp_list.dart';

class EmployeeFilter extends StatelessWidget {
  EmployeeFilter({super.key});

  final ValueNotifier<String> selecteddate = ValueNotifier('');

  final ValueNotifier<List<String>> selectEmp = ValueNotifier([]);

  final ValueNotifier<List<String>> selectedRating = ValueNotifier([]);

  final List<FilterModel> orderList = [
    FilterModel(label: 'Ascend', svg: AppImages.ascend),
    FilterModel(label: 'Descend', svg: AppImages.descend),
    FilterModel(label: 'None')
  ];

  final List<FilterModel> statusList = [
    FilterModel(label: 'Ascend', svg: AppImages.ascend),
    FilterModel(label: 'Descend', svg: AppImages.descend),
    FilterModel(label: 'None')
  ];

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
                              child: positionWidget(
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
                    AppStrings.positionText,
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
                    },
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
                    AppStrings.rating,
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
                valueListenable: selectedRating,
                builder: (context, value, child) {
                  return SelectionRating(onSelectRating: (ratingList) {
                    selectedRating.value = ratingList;
                  });
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
                    "Status",
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

  Widget positionWidget(Size kSize, FilterModel filter) {
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
}

/* import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:evantez/src/view/core//constants/app_strings.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/presentation/view/notification_view/widgets/selected_emp_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/themes/typography.dart';
import '../../../core/widgets/footer_button.dart';

class EmployeeFilter {
  BuildContext parentContext;

  EmployeeFilter(this.parentContext);

  Future show() async {
    final kSize = MediaQuery.of(parentContext).size;
    String selectedDate = '';
    List<FilterModel> selectedPositions = [];
    List<FilterModel> selectedRatings = [];
    String selectedStatus = '';
    /* List<String> selectedPosition = [];

    String joinDate = '';
    List<String> selectedRating = []; */

    List<Widget> sortByJoinDate = [
      filterExpTile(kSize, FilterModel(label: 'Ascend', svg: AppImages.ascend)),
      filterExpTile(kSize, FilterModel(label: 'Descend', svg: AppImages.descend)),
      filterExpTile(
          kSize,
          FilterModel(
            label: 'None',
          ))
    ];
    List<Widget> position = [
      filterExpTile(
          kSize,
          FilterModel(
            label: 'A Boy',
          )),
      filterExpTile(
          kSize,
          FilterModel(
            label: 'B Boy',
          )),
      filterExpTile(
          kSize,
          FilterModel(
            label: 'C Boy',
          )),
      filterExpTile(
          kSize,
          FilterModel(
            label: 'Fresher Boy',
          )),
      filterExpTile(
          kSize,
          FilterModel(
            label: 'Head',
          )),
      filterExpTile(
          kSize,
          FilterModel(
            label: 'Captain',
          )),
      filterExpTile(
          kSize,
          FilterModel(
            label: 'Vice Captain',
          )),
      filterExpTile(
          kSize,
          FilterModel(
            label: 'Supervisor',
          ))
    ];

    List<Widget> ratingItems = [
      filterExpTile(
        kSize,
        FilterModel(label: "5", svg: AppImages.starFill),
      ),
      filterExpTile(
        kSize,
        FilterModel(label: "4 - 4.99", svg: AppImages.starFill),
      ),
      filterExpTile(
        kSize,
        FilterModel(label: "3 - 3.99", svg: AppImages.starFill),
      ),
      filterExpTile(
        kSize,
        FilterModel(label: "2 - 2.99", svg: AppImages.starFill),
      ),
      filterExpTile(
        kSize,
        FilterModel(label: "1 - 1.99", svg: AppImages.starFill),
      ),
      filterExpTile(
        kSize,
        FilterModel(label: "0 - 0.99", svg: AppImages.starFill),
      )
    ];
    List<Widget> statusList = [
      filterExpTile(
        kSize,
        FilterModel(
          label: AppStrings.activeText,
        ),
      ),
      filterExpTile(
        kSize,
        FilterModel(
          label: 'Inactive',
        ),
      ),
    ];
    await showModalBottomSheet(
        context: parentContext,
        backgroundColor: AppColors.accentDark,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppConstants.basePadding),
                topRight: Radius.circular(
                  AppConstants.basePadding,
                ))),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(AppConstants.baseBorderRadius, AppConstants.baseBorderRadius,
                AppConstants.baseBorderRadius, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                header(context, kSize),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                expansIonWidget(
                    kSize: kSize,
                    items: sortByJoinDate,
                    title: AppStrings.sortByJoinDate,
                    onSelected: (index) {
                      //
                      // joinDate = sortByJoinDate[index];
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.positionText,
                      style: AppTypography.poppinsSemiBold.copyWith(
                        color: AppColors.secondaryColor,
                        fontSize: 18,
                      ),
                    ),
                    SvgPicture.asset(
                      AppImages.arrowDown,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                SizedBox(
                  width: kSize.width,
                  child: SelectEmpList(
                    onSelectedList: (empList) {
                      //
                    },
                  ),
                ),
                /* expansIonWidget(
                  kSize: kSize,
                  items: position,
                  title: AppStrings.positionText,
                  multiSelect: (value) {},
                ), */
                expansIonWidget(
                  kSize: kSize,
                  items: ratingItems,
                  title: AppStrings.rating,
                ),
                expansIonWidget(
                  kSize: kSize,
                  items: statusList,
                  title: 'Status',
                ),
                SizedBox(
                  height: kSize.height * 0.045,
                ),
                footer(kSize, context),
                SizedBox(
                  height: kSize.height * 0.045,
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

  Widget expansIonWidget(
      {required Size kSize,
      required List<Widget> items,
      required String title,
      Function(int)? multiSelect,
      Function(int)? onSelected}) {
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
            spacing: kSize.height * 0.012,
            runSpacing: kSize.height * 0.012,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            // crossAxisAlignment: WrapCrossAlignment.start,
            children: List.generate(
                items.length,
                (index) => InkWell(
                    highlightColor: AppColors.transparent,
                    splashColor: AppColors.transparent,
                    onTap: () {
                      if (onSelected != null) {
                        onSelected(index);
                      }
                      if (multiSelect != null) {
                        multiSelect(index);
                      }
                    },
                    child: items[index])),
          ),
        )
      ],
    );
  }

  Widget filterExpTile(Size kSize, FilterModel filter) {
    return Container(
      // margin: const EdgeInsets.only(right: 8.0),
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
            Padding(
              padding: filter.svg == AppImages.star ? const EdgeInsets.only(right: 12) : EdgeInsets.zero,
              child: SvgPicture.asset(
                filter.svg!,
                height: kSize.height * 0.02,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget footer(Size kSize, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FooterButton(
            fillColor: AppColors.transparent,
            width: kSize.width * 0.4,
            label: "Cancel",
            onTap: () {
              //
              Navigator.pop(context);
            }),
        FooterButton(
          width: kSize.width * 0.4,
          label: "Save",
          onTap: () {
            //
          },
        ),
      ],
    );
  }
}
*/

class FilterModel {
  String? label;
  String? svg;

  FilterModel({this.label, this.svg});
}
