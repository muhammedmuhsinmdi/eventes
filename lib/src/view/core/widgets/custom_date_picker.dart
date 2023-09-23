import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';

class CustomDatePicker extends StatefulWidget {
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
  const CustomDatePicker({
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

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final ValueNotifier<String> valueCheck = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    valueCheck.value = controller != null && controller!.text.isNotEmpty ? controller!.text : "";
    final kSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
                  onChanged: widget.onChanged,
                  cursorColor: AppColors.secondaryColor,
                  controller: widget.controller,
                  onTap: widget.readOnly != null && widget.readOnly!
                      ? null
                      : () async {
                          if (widget.type == "Date") {
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
                          } else if (widget.type == "Time") {
                            String st = '';
                            String et = '';
                            TimeOfDay? startTime;
                            TimeOfDay? endTime;
                            if (context.mounted) {
                              startTime = await showTimePicker(
                                  helpText: "Start Time",
                                  context: context,
                                  initialTime: TimeOfDay.now());

                              if (context.mounted) {
                                endTime = await showTimePicker(
                                    helpText: "End Time",
                                    context: context,
                                    initialTime: TimeOfDay.now());
                              }

                              if (context.mounted) {
                                st = startTime != null
                                    ? startTime.format(context)
                                    : '--:--';
                                et = endTime != null
                                    ? endTime.format(context)
                                    : '--:--';
                              }
                              if (widget.controller != null) {
                                widget.controller!.text = "$st - $et";
                                valueCheck.value = widget.controller!.text;
                                widget.onChanged(widget.controller!.text);
                              }
                            }
                          }
                        },
                  onSaved: widget.onSaved,
                  autocorrect: false,
                  textAlign: TextAlign.center,
                  textCapitalization: TextCapitalization.words,
                  style: AppTypography.poppinsMedium.copyWith(
                    color: AppColors.secondaryColor,
                    fontSize: 12,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Select ${widget.label}";
                    }
                    return null;
                  },
                  onFieldSubmitted: widget.onFieldSubmitted,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    // label: widget.label,
                    hintText: widget.hintText,
                    suffixIcon: widget.type != null
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
                        borderRadius: BorderRadius.circular(
                            AppConstants.baseBorderRadius),
                        borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: widget.fillColor == AppColors.transparent
                                ? AppColors.accentColor
                                : AppColors.transparent)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            AppConstants.baseBorderRadius),
                        borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: widget.fillColor == AppColors.transparent
                                ? AppColors.statusCritical
                                : AppColors.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            AppConstants.baseBorderRadius),
                        borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: widget.fillColor == AppColors.transparent
                                ? AppColors.accentColor
                                : AppColors.transparent)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            AppConstants.baseBorderRadius),
                        borderSide: const BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: AppColors.statusCritical)),
                    errorStyle: const TextStyle(),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            AppConstants.baseBorderRadius),
                        borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: widget.fillColor == AppColors.transparent
                                ? AppColors.accentColor
                                : AppColors.transparent)),
                    filled: true,
                    isDense: true,
                    fillColor: widget.fillColor ?? AppColors.accentDark,
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
