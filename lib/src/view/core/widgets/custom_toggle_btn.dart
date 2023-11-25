import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:flutter/material.dart';

class CustomToggleBtn extends StatefulWidget {
  final Function(bool) onChanged;
  late bool active;
  CustomToggleBtn({super.key, required active,required this.onChanged}){
    this.active = active;
  }

  @override
  State<CustomToggleBtn> createState() => _CustomToggleBtnState();
}

class _CustomToggleBtnState extends State<CustomToggleBtn> {
  

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return InkWell(
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      onTap: () {
        widget.active = !widget.active;
        widget.onChanged(widget.active);
      },
      child: AnimatedContainer(
        clipBehavior: Clip.antiAlias,
        height: kSize.height * 0.032,
        width: kSize.width * 0.16,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: kSize.height * 0.0015, horizontal: kSize.width * 0.01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.basePadding),
          color: widget.active ? AppColors.statusSuccess : AppColors.statusCritical,
        ),
        duration: const Duration(milliseconds: 100),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: kSize.height * 0.0015, horizontal: kSize.width * 0.013),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.active)
                    Text(
                      'YES',
                      maxLines: 1,
                      style: AppTypography.poppinsMedium.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  const Spacer(),
                  // SizedBox(
                  //   width: kSize.width * 0.01,
                  // ),
                  if (!widget.active)
                    Text(
                      'NO',
                      maxLines: 1,
                      style: AppTypography.poppinsMedium.copyWith(
                        fontSize: 14,
                      ),
                    )
                ],
              ),
            ),
            AnimatedAlign(
              curve: Curves.ease,
              alignment: widget.active ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 100),
              child: Container(
                height: kSize.height * 0.027,
                width: kSize.height * 0.027,
                decoration: const BoxDecoration(
                  color: AppColors.secondaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
