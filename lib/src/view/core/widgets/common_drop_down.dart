import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:evantez/src/view/core/constants/app_images.dart';
import 'package:evantez/src/view/core/constants/app_strings.dart';
import 'package:evantez/src/view/core/constants/constants.dart';
import 'package:evantez/src/view/core/themes/colors.dart';
import 'package:evantez/src/view/core/themes/typography.dart';
import 'package:evantez/src/view/core/widgets/drop_down_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonDropdown extends StatelessWidget {
  final String hintText;
  final List<DropDownValue> dropDownValue;
  final DropDownValue? selecteItem;
  final Function onChanged;
  final bool showSearchBox;
  final bool isVisibleClearButton;
  final String? label;
  final String? text;
  final bool? required;

  final bool? textAlignCenter;
  final String? Function(DropDownValue?)? validator;
  const CommonDropdown(
      {Key? key,
      required this.hintText,
      required this.dropDownValue,
      this.selecteItem,
      required this.onChanged,
      this.label,
      this.showSearchBox = true,
      this.isVisibleClearButton = false,
      this.textAlignCenter,
      this.validator,
      this.text,
      this.required})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (text != null && text!.isNotEmpty)
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
                      text: text,
                      style: AppTypography.poppinsMedium.copyWith(
                        fontSize: 16,
                        color: AppColors.secondaryColor,
                      ))
                ])),
          ),
        SizedBox(
          width: kSize.width,
          child: DropdownButtonHideUnderline(
              child: DropdownSearch<DropDownValue>(
            items: dropDownValue,
            selectedItem: selecteItem,
            dropdownButtonProps: DropdownButtonProps(
              hoverColor: Colors.transparent,
              icon: SvgPicture.asset(
                AppImages.arrowDropDown,
                colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                fit: BoxFit.contain,
              ),
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                hintText: hintText,
                focusedBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, style: BorderStyle.solid, color: AppColors.primaryColor)),
                enabledBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, style: BorderStyle.solid, color: AppColors.primaryColor)),
                border: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, style: BorderStyle.solid, color: AppColors.primaryColor)),
                contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                suffixIconColor: AppColors.primaryColor,
                errorBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, style: BorderStyle.solid, color: AppColors.statusCritical)),
              ),
              baseStyle: AppTypography.poppinsRegular.copyWith(
                color: AppColors.primaryColor,
                fontSize: 16,
              ),
            ),
            popupProps: PopupProps.bottomSheet(
                title: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (textAlignCenter != null && textAlignCenter!)
                        const Spacer(
                          flex: 2,
                        ),
                      Text(label != null ? "Select $label" : 'Title',
                          style: AppTypography.poppinsMedium.copyWith(
                            color: AppColors.secondaryColor,
                          )),
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
                ),
                bottomSheetProps: const BottomSheetProps(
                  backgroundColor: AppColors.darkBgColor2,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16)),
                  ),
                )),
            validator: validator,
            onChanged: (v) {
              onChanged(v);
            },
          )),
        )
      ],
    );
  }

  Widget selectedDropDownstyle(
    BuildContext context,
    DropDownValue? item,
  ) {
    if (item == null) {
      return Text(
        hintText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTypography.poppinsMedium.copyWith(
          color: AppColors.primaryColor,
          fontSize: 16,
        ),
      );
    } else {
      return Text(
        item.value ?? '',
        maxLines: 1,
        style: AppTypography.poppinsMedium.copyWith(
          color: AppColors.primaryColor,
          fontSize: 16,
        ),
        overflow: TextOverflow.ellipsis,
        // style: textfieldTextStyle,
      );
    }
  }

  Widget customPopupItemBuilder(
    BuildContext context,
    DropDownValue? item,
    bool isSelected,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                item?.value ?? '',
                // style: textfieldTextStyle.copyWith(
                //     fontSize: 14,
                //     fontWeight: FontWeight.w500,
                //     letterSpacing: 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
