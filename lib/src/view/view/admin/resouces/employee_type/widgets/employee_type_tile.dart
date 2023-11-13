// ignore_for_file: must_be_immutable

import 'package:evantez/src/controller/resources/employee/employee_controller.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:evantez/src/view/view/admin/resouces/employee_type/widgets/add_employee_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeTypeTile extends StatelessWidget {
  int index;
  EmployeeTypeTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    final controller = context.watch<EmployeesController>();
    return Container(
      width: kSize.width,
      margin: EdgeInsets.only(bottom: kSize.height * 0.012),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.basePadding),
        color: AppColors.accentDark,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: kSize.height * 0.016,
        vertical: kSize.height * 0.016,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.employeeTypes[index].name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.poppinsSemiBold.copyWith(
                  fontSize: 18,
                  color: AppColors.secondaryColor,
                ),
              ),
              RichText(
                text: TextSpan(
                    text: '${controller.employeeTypes[index].code}',
                    style: AppTypography.poppinsMedium.copyWith(
                        fontSize: 14,
                        color: AppColors.secondaryColor.withOpacity(0.5)),
                    children: [
                      TextSpan(
                          text:
                              '  ${controller.employeeTypes[index].amount}',
                          style: AppTypography.poppinsMedium.copyWith(
                            fontSize: 14,
                            color: AppColors.secondaryColor,
                          ))
                    ]),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: kSize.width * 0.1,
            child: PopupMenuButton<String>(
              initialValue: 'Edit',
              // Callback that sets the selected popup menu item.
              onSelected: (item) {
                // setState(() {
                // if (item == 'Edit') {
                // empTypeState.employeeType = employeeType;
                // empTypeState.nameEditingController.text = employeeType.name!;
                // empTypeState.codeEditingController.text = employeeType.code!;
                // empTypeState.employeeType = employeeType;
                controller.initStateLoading(
                    data: controller.employeeTypes[index]);
                AddEmployeeType(context, index).show();
                // }
                // });
              },
              clipBehavior: Clip.antiAlias,
              padding: EdgeInsets.symmetric(horizontal: kSize.height * 0.024),
              shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: AppColors.accentColor,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppConstants.basePadding,
                  )),

              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  padding: EdgeInsets.symmetric(
                    horizontal: kSize.width * 0.05,
                  ),
                  value: "edit",
                  child: Text(
                    'Edit',
                    textAlign: TextAlign.start,
                    style: AppTypography.poppinsMedium.copyWith(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
