import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/typography.dart';

class OtpField extends StatefulWidget {
  final TextEditingController? controller;
  final bool? first;
  final bool? last;
  final Function()? isFilled;
  final bool? readOnly;
  final bool? showCursor;
  final void Function(String)? onChanged;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;
  final Function()? onTap;
  const OtpField(
      {super.key,
      this.controller,
      this.first,
      this.last,
      this.isFilled,
      this.readOnly,
      this.showCursor,
      this.onChanged,
      this.height,
      this.width,
      this.contentPadding,
      this.focusNode,
      this.onTap});

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  // @override
  // void dispose() {
  //   widget.controller!.dispose();
  //   super.dispose();
  // }

  FocusNode node = FocusNode();
  
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Container(
      width: widget.width ?? kSize.width * .13,
      height: widget.height ?? kSize.height * .08,
      alignment: Alignment.center,
      child: TextFormField(
        maxLength: 1,
        onTap: widget.onTap,
        focusNode: widget.focusNode ?? node,
        controller: widget.controller,
        readOnly: widget.readOnly ?? false,
        showCursor: widget.showCursor ?? false,
        onChanged: widget.onChanged ??
            (value) {
              widget.isFilled!();
              if (value.length == 1 && widget.last == false) {
                FocusScope.of(context).nextFocus();
              }
              if (value.isEmpty && widget.first == false) {
                FocusScope.of(context).previousFocus();
              }
            },
        cursorColor: AppColors.blackColor,
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.next,
        style: AppTypography.poppinsSemiBold.copyWith(
          color: AppColors.secondaryColor,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          isDense: true,
          focusColor: AppColors.secondaryColor,
          counter: const SizedBox(),
          filled: true,
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(
                vertical: AppConstants.largePadding,
                horizontal: 5.0,
              ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(AppConstants.baseTextFieldBorderRdious),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(AppConstants.baseTextFieldBorderRdious),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(AppConstants.baseTextFieldBorderRdious),
          ),
          errorStyle: const TextStyle(),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
