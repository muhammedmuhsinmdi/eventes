import 'package:evantez/src/providers/resources/employee_type/employee_type_viewstate.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/typography.dart';
import '../../../../core/widgets/custom_textfield.dart';

class AddEmployeeType {
  BuildContext context;
  EmployeeTypeViewstate state;
  AddEmployeeType(this.context, this.state);

  Future show() async {
    final kSize = MediaQuery.of(context).size;
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
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
    return Form(
      key: state.formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Spacer(),
                Text(
                  "Add Employee Type",
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
              controller: TextEditingController(text: state.employeeType.name),
              validator: state.nameValidator,
              onSave: (val) {
                state.employeeType.name = val;
              },
            ),
            SizedBox(
              height: kSize.height * 0.024,
            ),
            CustomTextField(
              text: "Category Code",
              hintText: "Code",
              controller: TextEditingController(text: state.employeeType.code),
              validator: state.codeValidator,
              onSave: (val) {
                state.employeeType.code = val;
              },
            ),
            SizedBox(
              height: kSize.height * 0.024,
            ),
            const CustomTextField(
              text: "Amount",
              hintText: AppStrings.amountText,
            ),
            SizedBox(
              height: kSize.height * 0.032,
            ),
            Row(
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
                  label: "Save",
                  onTap: () {
                    state.save();
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
