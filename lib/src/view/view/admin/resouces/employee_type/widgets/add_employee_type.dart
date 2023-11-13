import 'dart:developer';

import 'package:evantez/src/controller/auth/auth_controller.dart';
import 'package:evantez/src/controller/resources/employee/employee_controller.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/themes/typography.dart';
import '../../../../../core/widgets/custom_textfield.dart';

class AddEmployeeType {
  BuildContext context;
  int index;

  AddEmployeeType(this.context, this.index);

  Future show() async {
    final kSize = MediaQuery.of(context).size;
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppConstants.basePadding),
                topRight: Radius.circular(AppConstants.basePadding))),
        backgroundColor: AppColors.accentDark,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: EdgeInsets.fromLTRB(AppConstants.baseBorderRadius, AppConstants.baseBorderRadius,
                  AppConstants.baseBorderRadius, kSize.height * 0.044),
              child: employeeType(context, kSize),
            ),
          );
        });
  }

  Widget employeeType(BuildContext context, Size kSize) {
    final controller = context.watch<EmployeesController>();
    final auth = context.watch<AuthController>();
    return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Spacer(),
                Text(
                  controller.isEdit ? "Update Employee Type" : "Add Employee Type",
                  style: AppTypography.poppinsSemiBold.copyWith(
                    fontSize: 18,
                    color: AppColors.secondaryColor,
                  ),
                ),
                const Spacer(),
                InkWell(
                    highlightColor: AppColors.transparent,
                    splashColor: AppColors.transparent,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppStrings.closeText,
                      style: AppTypography.poppinsMedium
                          .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6)),
                    ))
              ],
            ),
            SizedBox(
              height: kSize.height * 0.032,
            ),
            CustomTextField(
              text: "Category Name",
              hintText: "Name",
              controller: controller.nameTypeController,
              onSave: (val) {},
              validator: (value) {
                return value!.isEmpty ? "Category Name is Empty" : null;
              },
            ),
            SizedBox(
              height: kSize.height * 0.024,
            ),
            CustomTextField(
              text: "Category Code",
              hintText: "Code",
              controller: controller.codeController,
              onSave: (val) {},
              validator: (value) {
                return value!.isEmpty ? "Category Code is Empty" : null;
              },
            ),
            SizedBox(
              height: kSize.height * 0.024,
            ),
            CustomTextField(
              controller: controller.amount,
              text: "Amount",
              hintText: AppStrings.amountText,
              keyboardType: TextInputType.number,
              validator: (value) {
                return value!.isEmpty ? "Amount is Empty" : null;
              },
            ),
            SizedBox(
              height: kSize.height * 0.032,
            ),
            controller.isloading
                ? const CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FooterButton(
                          fillColor: AppColors.transparent,
                          width: kSize.width * 0.4,
                          label: "Cancel",
                          onTap: () {
                            Navigator.pop(context);
                          }),
                      FooterButton(
                        width: kSize.width * 0.4,
                        label: controller.isEdit ? "Update" : "Save",
                        onTap: () {
                          if (controller.formKey.currentState!.validate()) {
                            if (!controller.isloading) {
                              if (controller.isEdit) {
                                controller.editEmployeeType(
                                    token: auth.accesToken ?? '',
                                    context: context,
                                    id: controller.employeeTypes[index].id ?? 0);
                                log('test1');
                              } else {
                                log('test2');
                                controller
                                    .employeeTypeAdd(token: auth.accesToken ?? '', context: context)
                                    .then((value) {
                                  controller.employeeTypesData(token: auth.accesToken ?? '');
                                });
                              }
                            }
                          }
                        },
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
