import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:evantez/src/view/core//widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/widgets/custom_dropdown_search.dart';
import '../../../../../core/widgets/footer_button.dart';

class UrgentEmpSheet extends StatelessWidget {
  UrgentEmpSheet({super.key});

  final ValueNotifier<int> count = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: AppConstants.baseBorderRadius,
        top: kSize.height * 0.032,
        right: AppConstants.baseBorderRadius,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            Text(
              "Urgent Employee Needed",
              style: AppTypography.poppinsSemiBold.copyWith(
                color: AppColors.secondaryColor,
                fontSize: 18,
              ),
            ),
            SizedBox(height: kSize.height * 0.024),
            CustomTextField(
              text: '',
              style: AppTypography.poppinsRegular.copyWith(
                fontSize: 16,
              ),
              maxLines: 5,
              controller: TextEditingController(
                  text:
                      '10 A boys needed near Crown theater in half hour. call 91123123132'),
            ),
            /* Container(
              color: AppColors.transparent.withOpacity(0.1),
              height: kSize.height * 0.13,
              padding: const EdgeInsets.fromLTRB(
                  AppConstants.basePadding, AppConstants.basePadding, AppConstants.basePadding, 0),
              child: Text(
                '10 A boys needed near Crown theater in half hour. call 91123123132',
                textAlign: TextAlign.start,
                style: AppTypography.poppinsRegular.copyWith(),
              ),
            ), */
            const Divider(
              color: AppColors.primaryColor,
            ),
            SizedBox(height: kSize.height * 0.024),
            Container(
              width: kSize.width,
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              color: AppColors.blackColor.withOpacity(0.1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.more_vert,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(
                    width: kSize.width * 0.55,
                    child: const CustomDropdownSearch(
                      items: ["All Boys", "Captain", 'Vice Captain'],
                    ),
                  ),
                  SizedBox(
                    height: kSize.height * 0.1,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              count.value--;
                            },
                            icon: SvgPicture.asset(
                              AppImages.minuscircle,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.primaryColor, BlendMode.srcIn),
                            )),
                        Text(
                          '${count.value}',
                          style: AppTypography.poppinsRegular.copyWith(
                            color: AppColors.secondaryColor,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              count.value++;
                            },
                            icon: SvgPicture.asset(
                              AppImages.addCircle,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.primaryColor, BlendMode.srcIn),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: kSize.height * 0.024),

            FooterButton(
                fillColor: AppColors.transparent, label: 'Add +', onTap: () {}),
            SizedBox(height: kSize.height * 0.024),
            Divider(
              color: AppColors.secondaryColor.withOpacity(0.2),
            ),
            SizedBox(height: kSize.height * 0.024),
            footer(kSize, context),
            SizedBox(height: kSize.height * 0.032),
          ],
        ),
      ),
    );
  }

  Widget footer(Size kSize, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FooterButton(
            fillColor: AppColors.transparent,
            width: kSize.width * 0.4,
            label: "Cancel",
            onTap: () {
              //
              Navigator.pop(context);
            }),
        FooterButton(
          width: kSize.width * 0.4,
          label: "Save",
          onTap: () {
            //
          },
        ),
      ],
    );
  }
}

/* class UrgentEmpSheet {
  BuildContext context;
  UrgentEmpSheet(this.context);

  Future<void> show() async {
    return showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.accentDark,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppConstants.basePadding),
                topRight: Radius.circular(AppConstants.basePadding))),
        builder: (context) {
          return;
        });
  }
} */
