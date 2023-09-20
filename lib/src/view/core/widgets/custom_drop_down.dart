import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:evantez/src/view/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/constants.dart';

class CustomDropDown extends StatelessWidget {
  final String? label;
  final bool? required;
  final String? hintText;
  final List<String>? items;
  final List<Widget>? widgetItems;
  final Function(String)? onSelected;
  CustomDropDown(
      {super.key, this.label, this.required, this.items, this.hintText, this.widgetItems, this.onSelected});

  final ValueNotifier<String> dropDownValue = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    dropDownValue.value = items!.first;
    if (onSelected != null) {
      onSelected!(dropDownValue.value);
    }
    final kSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null && label!.isNotEmpty) ...{
          Padding(
            padding: EdgeInsets.only(bottom: kSize.height * 0.010),
            child: RichText(
                text: TextSpan(
                    text: required != null && required! ? '*  ' : '',
                    style: AppTypography.poppinsBold.copyWith(
                      color: AppColors.statusCritical,
                      fontSize: 16,
                    ),
                    children: [
                  TextSpan(
                      text: label,
                      style: AppTypography.poppinsMedium.copyWith(
                        fontSize: 16,
                        color: AppColors.secondaryColor,
                      ))
                ])),
          ),
        },
        ValueListenableBuilder(
            valueListenable: dropDownValue,
            builder: (context, value, child) {
              return DropdownButtonHideUnderline(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: AppColors.accentDark.withOpacity(0.1),
                      border: const Border(bottom: BorderSide(width: 2, color: AppColors.primaryColor))),
                  child: DropdownButton(
                    icon: SvgPicture.asset(
                      AppImages.arrowDropDown,
                      colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                    ),
                    style: AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor),
                    hint: Text(
                      hintText ?? '',
                      style: AppTypography.poppinsRegular
                          .copyWith(color: AppColors.secondaryColor.withOpacity(0.4)),
                    ),
                    isExpanded: true,
                    iconSize: 0,
                    // style: FontUtils.getFont14Style(color: AppColors.black),
                    items: items!.map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(
                            val,
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      // if (val != null) {
                      dropDownValue.value = val ?? '';
                      if (onSelected != null) {
                        onSelected!(dropDownValue.value);
                      }
                      // }

                      // widget.onSelected(ConvertService.convertString(val));
                      // setState(
                      //   () {
                      //     dropDownValue = val as String;
                      //   },
                      // );
                    },

                    value: dropDownValue.value,
                    borderRadius: BorderRadius.circular(AppConstants.basePadding),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: AppConstants.basePadding,
                    ),
                  ),
                ),
              );
            })
      ],
    );
  }
}
