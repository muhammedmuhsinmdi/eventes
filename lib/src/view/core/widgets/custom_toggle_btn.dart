import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:flutter/material.dart';

class CustomToggleBtn extends StatefulWidget {
  final Function(bool) onChanged;
  const CustomToggleBtn({super.key, required this.onChanged});

  @override
  State<CustomToggleBtn> createState() => _CustomToggleBtnState();
}

class _CustomToggleBtnState extends State<CustomToggleBtn> {
  final ValueNotifier<bool> active = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: active,
        builder: (context, value, child) {
          return InkWell(
            splashColor: AppColors.transparent,
            highlightColor: AppColors.transparent,
            onTap: () {
              active.value = !active.value;
              widget.onChanged(active.value);
            },
            child: AnimatedContainer(
              clipBehavior: Clip.antiAlias,
              height: kSize.height * 0.032,
              width: kSize.width * 0.16,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: kSize.height * 0.0015, horizontal: kSize.width * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.basePadding),
                color: active.value ? AppColors.statusSuccess : AppColors.statusCritical,
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
                        if (active.value)
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
                        if (!active.value)
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
                    alignment: active.value ? Alignment.centerRight : Alignment.centerLeft,
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
        });
  }
}
