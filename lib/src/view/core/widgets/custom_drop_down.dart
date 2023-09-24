import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:evantez/src/view/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/constants.dart';

class CustomDropDown extends StatefulWidget {
  final String? label;
  final bool? required;
  final String? intialValue;
  final String? hintText;
  final List<String>? items;
  final List<Widget>? widgetItems;
  final Function(String)? onSelected;
  const CustomDropDown(
      {super.key,
      this.label,
      this.required,
      this.items,
      this.hintText,
      this.widgetItems,
      this.onSelected,
      this.intialValue});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  final ValueNotifier<String> dropDownValue = ValueNotifier<String>('');

  @override
  void initState() {
    dropDownValue.value = widget.items!.first;
    if (widget.intialValue != null && widget.intialValue!.isNotEmpty) {
      dropDownValue.value = widget.intialValue!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null && widget.label!.isNotEmpty) ...{
          Padding(
            padding: EdgeInsets.only(bottom: kSize.height * 0.010),
            child: RichText(
                text: TextSpan(
                    text: widget.required != null && widget.required! ? '*  ' : '',
                    style: AppTypography.poppinsBold.copyWith(
                      color: AppColors.statusCritical,
                      fontSize: 16,
                    ),
                    children: [
                  TextSpan(
                      text: widget.label,
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
                      widget.hintText ?? '',
                      style: AppTypography.poppinsRegular
                          .copyWith(color: AppColors.secondaryColor.withOpacity(0.4)),
                    ),
                    isExpanded: true,
                    iconSize: 0,
                    // style: FontUtils.getFont14Style(color: AppColors.black),
                    items: widget.items!.map(
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
                      if (widget.onSelected != null) {
                        widget.onSelected!(dropDownValue.value);
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
