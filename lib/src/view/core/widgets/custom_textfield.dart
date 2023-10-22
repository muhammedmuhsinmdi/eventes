import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    this.suffix,
    this.prefix,
    this.controller,
    this.validator,
    this.errorMessage,
    this.maxLength,
    this.keyboardType,
    this.onTap,
    this.onSave,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintStyle,
    this.decoration,
    this.style,
    this.textAlignVertical,
    this.inputFormatters,
    this.snackBar,
    this.autofocus,
    this.enableInteractiveSelection,
    this.onChanged,
    this.maxLines,
    this.readOnly,
    this.textInputAction,
    this.label,
    required this.text,
    this.passwordField = false,
    this.required,
    this.obscureText,
    this.onSubmit,
    this.labelStyle,
    this.contentPadding,
  }) : super(key: key);
  final Widget? suffix;
  final Widget? prefix;
  final String? errorMessage;
  final int? maxLength;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String?)? onSubmit;
  final TextEditingController? controller;
  final Function()? onTap;
  final Function(String?)? onSave;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputDecoration? decoration;
  final TextStyle? style;
  final TextAlignVertical? textAlignVertical;
  final List<TextInputFormatter>? inputFormatters;
  final ScaffoldState? snackBar;
  final bool? autofocus;
  final bool? enableInteractiveSelection;
  final Function(String)? onChanged;
  final int? maxLines;
  final bool? readOnly;
  final TextInputAction? textInputAction;
  final Widget? label;
  final String text;
  final bool passwordField;
  final bool? obscureText;
  final bool? required;
  final TextStyle? labelStyle;
  final EdgeInsets? contentPadding;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.text.isNotEmpty)
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
                      text: widget.text,
                      style: widget.labelStyle ??
                          AppTypography.poppinsMedium.copyWith(
                            fontSize: 16,
                            color: AppColors.secondaryColor,
                          ))
                ])),
          ),
        SizedBox(
          width: kSize.width,
          child: TextFormField(
            readOnly: widget.readOnly ?? false,
            maxLines: widget.maxLines,
            onChanged: widget.onChanged,
            inputFormatters: widget.inputFormatters,
            autofocus: widget.autofocus ?? false,
            cursorColor: AppColors.secondaryColor,
            obscureText: widget.passwordField ? obscureText : false,
            controller: widget.controller,
            onTap: widget.onTap,
            onSaved: widget.onSave,
            autocorrect: false,
            textAlign: TextAlign.left,
            textInputAction: widget.textInputAction,
            // textCapitalization: TextCapitalization.words,
            textAlignVertical: widget.textAlignVertical,
            //enableInteractiveSelection: widget.enableInteractiveSelection ?? false,
            style: widget.style ??
                AppTypography.poppinsMedium.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                ),
            keyboardType: widget.keyboardType,
            maxLength: widget.maxLength,
            validator: widget.validator ??
                (value) {
                  if (value == null || value.isEmpty) {
                    return widget.errorMessage;
                  }
                  return null;
                },
            onFieldSubmitted: widget.onSubmit,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: widget.decoration ??
                InputDecoration(
                  label: widget.label,
                  hintText: widget.hintText,
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.passwordField ? passwordIcon() : widget.suffixIcon,
                  hintStyle: widget.hintStyle ??
                      AppTypography.poppinsRegular.copyWith(
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
                  prefix: widget.prefix,
                  suffix: widget.suffix,
                  contentPadding: widget.contentPadding ??
                      const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: AppConstants.basePadding,
                      ),
                ),
          ),
        ),
      ],
    );
  }

  Widget passwordIcon() {
    return IconButton(
      highlightColor: AppColors.transparent,
      splashColor: AppColors.transparent,
      onPressed: () {
        setState(
          () {
            obscureText = !obscureText;
          },
        );
      },
      icon: Icon(
        obscureText ? Icons.visibility_rounded : Icons.visibility_off_rounded,
        color: obscureText ? AppColors.primaryColor : AppColors.primaryColor,
      ),
    );
  }
}
