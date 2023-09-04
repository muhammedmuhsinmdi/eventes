import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';

class CustomDatePicker extends StatelessWidget {
  final String? label;
  final bool? required;
  final String? type;
  final bool? readOnly;
  final Color? fillColor;
  final String? hintText;
  final Function(String) onChanged;
  final TextEditingController? controller;
  final Function()? onTap;
  final Function(String?)? onSaved;
  final Function(String)? onFieldSubmitted;
  final Widget? sufficIcon;
  CustomDatePicker({
    super.key,
    this.label,
    this.required,
    this.hintText,
    required this.onChanged,
    this.controller,
    this.onTap,
    this.onSaved,
    this.onFieldSubmitted,
    this.sufficIcon,
    this.type,
    this.fillColor,
    this.readOnly,
  });

  final ValueNotifier<String> valueCheck = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    valueCheck.value = controller != null && controller!.text.isNotEmpty ? controller!.text : "";
    final kSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
                  ),
                ),
              ],
            )),
          ),
        },
        ValueListenableBuilder(
            valueListenable: valueCheck,
            builder: (context, value, child) {
              return SizedBox(
                width: kSize.width / 2.35,
                child: TextFormField(
                  readOnly: true,
                  maxLines: 1,
                  onChanged: onChanged,
                  cursorColor: AppColors.secondaryColor,
                  controller: controller,
                  onTap: readOnly != null && readOnly!
                      ? null
                      : () async {
                          if (type == "Date") {
                            DateTime? date = await showDatePicker(
                                helpText: 'Select Event Date',
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1990),
                                lastDate: DateTime(2050));
                            if (date != null) {
                              if (controller != null) {
                                controller!.text = DateFormat("dd MMM, yyyy").format(date);
                                valueCheck.value = controller!.text;
                                onChanged(controller!.text);
                              }
                            }
                          } else if (type == "Time") {
                            String st = '';
                            String et = '';
                            TimeOfDay? startTime;
                            TimeOfDay? endTime;
                            if (context.mounted) {
                              startTime = await showTimePicker(
                                  helpText: "Start Time", context: context, initialTime: TimeOfDay.now());

                              if (context.mounted) {
                                endTime = await showTimePicker(
                                    helpText: "End Time", context: context, initialTime: TimeOfDay.now());
                              }

                              if (context.mounted) {
                                st = startTime != null ? startTime.format(context) : '--:--';
                                et = endTime != null ? endTime.format(context) : '--:--';
                              }
                              if (controller != null) {
                                controller!.text = "$st - $et";
                                valueCheck.value = controller!.text;
                                onChanged(controller!.text);
                              }
                            }
                          }
                        },
                  onSaved: onSaved,
                  autocorrect: false,
                  textAlign: TextAlign.center,
                  textCapitalization: TextCapitalization.words,
                  style: AppTypography.poppinsMedium.copyWith(
                    color: AppColors.secondaryColor,
                    fontSize: 12,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Select $label";
                    }
                    return null;
                  },
                  onFieldSubmitted: onFieldSubmitted,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    // label: widget.label,
                    hintText: hintText,
                    suffixIcon: type != null
                        ? Padding(
                            padding: const EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              type == "Date" ? AppImages.calender : AppImages.clock,
                              colorFilter: ColorFilter.mode(
                                valueCheck.value.isNotEmpty
                                    ? AppColors.primaryColor
                                    : AppColors.secondaryColor.withOpacity(0.6),
                                BlendMode.srcIn,
                              ),
                            ),
                          )
                        : null,
                    hintStyle: AppTypography.poppinsRegular.copyWith(
                      color: AppColors.secondaryColor.withOpacity(0.4),
                      fontSize: 16,
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius),
                        borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: fillColor == AppColors.transparent
                                ? AppColors.accentColor
                                : AppColors.transparent)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius),
                        borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: fillColor == AppColors.transparent
                                ? AppColors.statusCritical
                                : AppColors.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius),
                        borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: fillColor == AppColors.transparent
                                ? AppColors.accentColor
                                : AppColors.transparent)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius),
                        borderSide: const BorderSide(
                            width: 1, style: BorderStyle.solid, color: AppColors.statusCritical)),
                    errorStyle: const TextStyle(),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius),
                        borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: fillColor == AppColors.transparent
                                ? AppColors.accentColor
                                : AppColors.transparent)),
                    filled: true,
                    isDense: true,
                    fillColor: fillColor ?? AppColors.accentDark,
                    counter: const SizedBox(),
                    focusColor: AppColors.secondaryColor,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: AppConstants.marginSpace,
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
