import 'package:dropdown_search/dropdown_search.dart';
import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:evantez/src/view/core//constants/app_strings.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDropdownSearch extends StatelessWidget {
  final String? label;
  final bool? required;
  final Color? labelTextColor;
  final String? hintText;
  final bool? textAlignCenter;
  final List<String>? items;
  final String? Function(String?)? validator;
  final Function(String?)? onSave;
  final Function(String?)? onChanged;
  const CustomDropdownSearch(
      {super.key,
      this.label,
      this.required,
      this.items,
      this.hintText,
      this.validator,
      this.onSave,
      this.labelTextColor,
      this.onChanged,
      this.textAlignCenter});

  @override
  Widget build(BuildContext context) {
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
                        color: labelTextColor ??
                            AppColors.secondaryColor.withOpacity(0.6),
                      ))
                ],
              ),
            ),
          ),
        },
        SizedBox(
          width: kSize.width,
          child: DropdownButtonHideUnderline(
              child: DecoratedBox(
            decoration: const BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(width: 2, color: AppColors.primaryColor))),
            child: DropdownSearch<String>(
                dropdownButtonProps: DropdownButtonProps(
                  hoverColor: Colors.transparent,
                  icon: SvgPicture.asset(
                    AppImages.arrowDropDown,
                    colorFilter: const ColorFilter.mode(
                        AppColors.primaryColor, BlendMode.srcIn),
                    fit: BoxFit.contain,
                  ),
                ),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    suffixIconColor: AppColors.primaryColor,
                    errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 2,
                            style: BorderStyle.solid,
                            color: AppColors.statusCritical)),
                  ),
                  baseStyle: AppTypography.poppinsRegular.copyWith(
                    color: AppColors.secondaryColor,
                    fontSize: 16,
                  ),
                ),
                popupProps: PopupProps.bottomSheet(
                    showSelectedItems: true,
                    title: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.baseBorderRadius,
                          vertical: 16),
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
                                  color:
                                      AppColors.secondaryColor.withOpacity(0.4),
                                )),
                          )
                        ],
                      ),
                    ),
                    bottomSheetProps: const BottomSheetProps(
                      backgroundColor: AppColors.darkBgColor2,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            topLeft: Radius.circular(16)),
                      ),
                    )),
                validator: validator,
                onSaved: onSave,
                onChanged: onChanged,
                items: items!),
          )),
        )
      ],
    );
  }
}
