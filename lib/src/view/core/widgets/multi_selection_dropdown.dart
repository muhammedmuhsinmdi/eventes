import 'dart:developer';

import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//widgets/custom_dropdown_search.dart';
import 'package:evantez/src/view/core//widgets/custom_textfield.dart';
import 'package:evantez/src/view/core/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_strings.dart';
import '../constants/constants.dart';

class MultiSelectionDropDown extends StatelessWidget {
  final String label;
  final bool? required;
  final Color? labelTextColor;
  final List<String> items;
  final String? intialValue;
  final bool? isEmployeeAssign;
  final Function(List<String>)? onSelectedEmp;
  MultiSelectionDropDown(
      {super.key,
      required this.label,
      required this.items,
      this.intialValue,
      this.isEmployeeAssign,
      this.onSelectedEmp,
      this.required,
      this.labelTextColor});

  final TextEditingController _totalController = TextEditingController();

  final TextEditingController wageController = TextEditingController();

  final ValueNotifier<double> serviceWage = ValueNotifier<double>(0);

  final ValueNotifier<int> count = ValueNotifier<int>(1);

  final ValueNotifier<List<String>> selectedEmpList = ValueNotifier<List<String>>([]);

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor.withOpacity(0.03),
      ),
      width: kSize.width,
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 12),
      margin: EdgeInsets.only(bottom: kSize.height * 0.032),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: kSize.width * 0.05,
                child: PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_vert,
                    color: AppColors.primaryColor,
                  ),
                  // color: AppColors.primaryColor,
                  initialValue: 'remove',
                  // Callback that sets the selected popup menu item.
                  onSelected: (item) {
                    // setState(() {
                    log(item);
                    // });
                  },
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: AppColors.accentColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppConstants.basePadding,
                      )),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      padding: EdgeInsets.symmetric(
                        horizontal: kSize.width * 0.05,
                      ),
                      value: "remove",
                      child: Text(
                        'Remove Item',
                        textAlign: TextAlign.start,
                        style: AppTypography.poppinsMedium.copyWith(),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: kSize.width * 0.55,
                        child: CustomDropdownSearch(
                          items: items,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          width: kSize.width * 0.2,
                          child: CustomTextField(
                            keyboardType: TextInputType.number,
                            controller: wageController,
                            onChanged: (value) {
                              _totalController.text = value;
                            },
                            text: '',
                          )),
                    ],
                  ),
                  SizedBox(
                    width: kSize.width * 0.8,
                    child: ValueListenableBuilder(
                        valueListenable: count,
                        builder: (context, value, child) {
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if (count.value > 1) {
                                      if (wageController.text.isNotEmpty) {
                                        count.value--;
                                        double wg = double.parse(wageController.text);
                                        _totalController.text = "${(wg * count.value).toInt()}";
                                      }
                                    }
                                  },
                                  icon: SvgPicture.asset(
                                    AppImages.minuscircle,
                                    colorFilter:
                                        const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                                  )),
                              Text(
                                '${count.value}',
                                style: AppTypography.poppinsRegular.copyWith(
                                  color: AppColors.secondaryColor,
                                  fontSize: 16,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    if (wageController.text.isNotEmpty) {
                                      count.value++;
                                      double wg = double.parse(wageController.text);
                                      _totalController.text = "${(wg * count.value).toInt()}";
                                    }
                                  },
                                  icon: SvgPicture.asset(
                                    AppImages.addCircle,
                                    colorFilter:
                                        const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                                  )),
                              const SizedBox(
                                width: 14,
                              ),
                              Text(
                                'Total',
                                style: AppTypography.poppinsRegular.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              SizedBox(
                                  width: kSize.width * 0.27,
                                  child: CustomTextField(
                                    readOnly: true,
                                    controller: _totalController,
                                    text: '',
                                  )),
                            ],
                          );
                        }),
                  ),
                  Text(
                    'Assign To',
                    style: AppTypography.poppinsMedium.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  assignedTile(context, kSize)
                  /* if (isEmployeeAssign != null && isEmployeeAssign!) ...{
                    SizedBox(
                        width: kSize.width * 0.8,
                        child: const CustomDropdownSearch(
                          label: 'Assign to',
                          items: [
                            "Roshan",
                            "Suhail",
                            "Rahul",
                            "John",
                            "Amal",
                          ],
                        ))
                    
                  } */
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget assignedTile(BuildContext context, Size kSize) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            backgroundColor: AppColors.accentDark,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppConstants.basePadding),
              topRight: Radius.circular(AppConstants.basePadding),
            )),
            builder: (context) {
              return bottomSheetItemList(context, kSize);
            });
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: kSize.width * 0.8,
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.primaryColor))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Wrap(
                  spacing: 8,
                  runSpacing: 12,
                  children: List.generate(
                    3,
                    (index) => Container(
                      clipBehavior: Clip.antiAlias,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor, borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        "HFDuuihiu",
                        style: AppTypography.poppinsRegular.copyWith(
                          color: AppColors.secondaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )),
            ),
            SvgPicture.asset(
              AppImages.arrowDropDown,
              colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomSheetItemList(BuildContext context, Size kSize) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppConstants.baseBorderRadius, AppConstants.baseBorderRadius, AppConstants.baseBorderRadius, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Spacer(
                flex: 2,
              ),
              Text(
                "Assign To Employee",
                style: AppTypography.poppinsSemiBold.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(AppStrings.closeText,
                    style: AppTypography.poppinsMedium.copyWith(
                      color: AppColors.secondaryColor.withOpacity(0.4),
                    )),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppConstants.baseBorderRadius),
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
          Padding(
              padding: const EdgeInsets.symmetric(vertical: AppConstants.baseBorderRadius),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 12,
                runSpacing: 12,
                children: List.generate(
                    3,
                    (index) => Container(
                          clipBehavior: Clip.antiAlias,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor, borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "HFDuuihiu",
                                style: AppTypography.poppinsRegular.copyWith(
                                  color: AppColors.secondaryColor,
                                  fontSize: 12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: InkWell(
                                  onTap: () {
                                    //
                                  },
                                  child: SvgPicture.asset(
                                    AppImages.crossCircle,
                                    height: 14,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.secondaryColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
              )),
          Expanded(
              child: ListView.separated(
                  itemCount: 12,
                  padding: const EdgeInsets.only(bottom: AppConstants.baseBorderRadius),
                  separatorBuilder: (context, index) {
                    return const Padding(padding: EdgeInsets.only(bottom: 8));
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.secondaryColor.withOpacity(0.2),
                      ),
                      width: kSize.width,
                      child: RichText(
                        text: TextSpan(
                            text: "Roshan",
                            style: AppTypography.poppinsRegular.copyWith(
                              fontSize: 16,
                              color: AppColors.secondaryColor,
                            ),
                            children: [
                              TextSpan(
                                text: " Supervisor",
                                style: AppTypography.poppinsRegular.copyWith(
                                  fontSize: 16,
                                  color: AppColors.secondaryColor.withOpacity(0.4),
                                ),
                              )
                            ]),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
