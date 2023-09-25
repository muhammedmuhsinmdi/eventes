import 'dart:developer';

import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//widgets/custom_rating_star.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/themes/typography.dart';

class FilterBoysRating extends StatefulWidget {
  final Function(String) onSelected;
  const FilterBoysRating({
    super.key,
    required this.onSelected,
  });

  @override
  State<FilterBoysRating> createState() => _FilterBoysRatingState();
}

class _FilterBoysRatingState extends State<FilterBoysRating> {
  List<String> ratingWidgets = List.generate(5, (index) => "${index + 1}");

  ValueNotifier<double> filterValue = ValueNotifier<double>(0.0);

  @override
  void initState() {
    widget.onSelected(ratingWidgets.first);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: filterValue,
        builder: (context, value, child) {
          return SizedBox(
            width: kSize.width,
            child: DropdownButtonFormField(
              items: ratingWidgets.map((val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Row(
                    children: [
                      CustomRatingStar(
                        onRating: (ratingValue) {
                          log('$ratingValue');
                          filterValue.value = ratingValue;
                          widget.onSelected("$ratingValue");
                        },
                        initialRating: double.parse(val),
                      ),
                      Text(
                        double.parse(val).toString(),
                        style: AppTypography.poppinsMedium.copyWith(
                          fontSize: 14,
                          color: AppColors.secondaryColor.withOpacity(0.4),
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                widget.onSelected("$value");
              },
              icon: const SizedBox(),
              borderRadius: BorderRadius.circular(24),
              decoration: InputDecoration(
                // label: widget.label,
                // hintText: widget.hintText,
                // prefixIcon: widget.prefixIcon,
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: SvgPicture.asset(
                    AppImages.arrowDropDown,
                    colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                    fit: BoxFit.contain,
                  ),
                ),
                hintStyle: AppTypography.poppinsRegular.copyWith(
                  color: AppColors.secondaryColor.withOpacity(0.4),
                  fontSize: 16,
                ),
                focusedBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, style: BorderStyle.solid, color: AppColors.primaryColor)),
                errorBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, style: BorderStyle.solid, color: AppColors.statusCritical)),
                errorStyle: const TextStyle(),
                border: InputBorder.none,
                enabledBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, style: BorderStyle.solid, color: AppColors.primaryColor)),
                filled: true,
                isDense: true,
                fillColor: AppColors.transparent.withOpacity(0.1),
                counter: const SizedBox(),
                focusColor: AppColors.secondaryColor,
                // prefix: widget.prefix,
                // suffix: widget.suffix,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: AppConstants.basePadding,
                ),
              ),
            ),
          );
        });
  }
}
