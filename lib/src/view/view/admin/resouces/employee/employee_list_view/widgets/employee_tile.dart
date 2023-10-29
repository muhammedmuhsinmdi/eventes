// ignore_for_file: unrelated_type_equality_checks

import 'package:evantez/src/controller/resources/employee/employee_controller.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeTile extends StatelessWidget {
  final int index;
  const EmployeeTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<EmployeesController>();

    final kSize = MediaQuery.of(context).size;
    String name = '';
    switch (controller.employeeLists[index].employeeType) {
      case 1:
        name = 'Head';
        break;
      case 10:
        name = 'Junior';
      default:
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppTypography.poppinsSemiBold.copyWith(
            fontSize: 18,
            color: AppColors.secondaryColor,
          ),
        ),
        SizedBox(
          height: kSize.height * 0.024,
        ),
        Column(
          // children: List.generate(
          //   index == 0 ? 1 : 3,
          //   (index) =>
          //

          //  ),

          children: [
            Container(
              // margin: EdgeInsets.only(bottom: kSize.height * 0),
              clipBehavior: Clip.antiAlias,
              padding: EdgeInsets.symmetric(
                  horizontal: kSize.height * 0.016,
                  vertical: kSize.height * 0.016),
              width: kSize.width,
              decoration: BoxDecoration(
                color: AppColors.accentDark,
                border: Border.all(color: AppColors.accentColor),
                borderRadius: BorderRadius.circular(AppConstants.basePadding),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    height: kSize.height * 0.080,
                    width: kSize.height * 0.080,
                    child: const Placeholder(),
                  ),
                  SizedBox(
                    width: kSize.width * 0.01,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.employeeLists[index].homeContact ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.poppinsMedium.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: kSize.height * 0.004,
                      ),
                      RichText(
                          text: TextSpan(
                              text: 'EM ',
                              style: AppTypography.poppinsMedium.copyWith(
                                  fontSize: 14,
                                  color: AppColors.secondaryColor
                                      .withOpacity(0.6)),
                              children: [
                            TextSpan(
                                text: controller.employeeLists[index].code,
                                style: AppTypography.poppinsMedium.copyWith(
                                    color: AppColors.secondaryColor,
                                    fontSize: 14))
                          ])),
                      SizedBox(
                        height: kSize.height * 0.004,
                      ),
                      RichText(
                          text: TextSpan(
                              text: 'ID ',
                              style: AppTypography.poppinsMedium.copyWith(
                                  fontSize: 14,
                                  color: AppColors.secondaryColor
                                      .withOpacity(0.6)),
                              children: [
                            TextSpan(
                                text: controller
                                    .employeeLists[index].idProofNumber,
                                style: AppTypography.poppinsMedium.copyWith(
                                    color: AppColors.secondaryColor,
                                    fontSize: 14))
                          ])),
                    ],
                  )),
                  Container(
                    margin: EdgeInsets.only(
                        right: kSize.width * 0.02, top: kSize.height * 0.005),
                    height: kSize.height * 0.01,
                    width: kSize.height * 0.01,
                    decoration: BoxDecoration(
                      color: controller.employeeLists[index].isActive == true
                          ? AppColors.statusSuccess
                          : AppColors.statusCritical,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    controller.employeeLists[index].isActive == true
                        ? "Active"
                        : 'Inactive',
                    style: AppTypography.poppinsRegular.copyWith(
                      fontSize: 12,
                      color: AppColors.secondaryColor.withOpacity(0.6),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
