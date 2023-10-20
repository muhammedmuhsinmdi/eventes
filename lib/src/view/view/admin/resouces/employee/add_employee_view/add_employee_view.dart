import 'package:evantez/src/model/repository/auth/auth_controller.dart';
import 'package:evantez/src/model/repository/resource/employee/add_employee_controller.dart';
import 'package:evantez/src/model/repository/resource/employee_repository.dart';
import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//widgets/custom_dropdown_search.dart';
import 'package:evantez/src/view/core//widgets/custom_textfield.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:evantez/src/view/core/widgets/common_drop_down.dart';
import 'package:evantez/src/view/core/widgets/drop_down_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/themes/typography.dart';
import '../../../../../core/widgets/custom_back_btn.dart';

class AddEmployeeView extends StatelessWidget {
  const AddEmployeeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<EmployeesController>();
    final empController = context.watch<AddEmployeeController>();
    final auth = context.watch<AuthController>();
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar(context, kSize),
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppConstants.baseBorderRadius, AppConstants.baseBorderRadius,
                AppConstants.baseBorderRadius, 0),
            child: Form(
              key: empController.employeeForm,
              child: Column(
                children: [
                  uploadProImage(kSize),
                  SizedBox(
                    height: kSize.height * 0.040,
                  ),
                  CustomTextField(
                    controller: empController.nameController,
                    text: AppStrings.fullNameText,
                    required: true,
                    hintText: "Enter ${AppStrings.fullNameText}",
                    validator: empController.nameValidator,
                    onSave: (val){
                       empController.employee.employeeName = val;
                    },
                  ),
                  SizedBox(
                    height: kSize.height * 0.040,
                  ),
                  CustomTextField(
                    controller: empController.codeController,
                    text: AppStrings.fullNameText,
                    required: true,
                    hintText: "Enter ${AppStrings.employeeCode}",
                    validator: empController.codeValidator,
                    onSave: (val){
                       empController.employee.code = val;
                    },
                  ),
                  SizedBox(
                    height: kSize.height * 0.040,
                  ),
                  CommonDropdown(
                      hintText: 'Select Employee Type',
                      dropDownValue: empController.types,
                      selecteItem: empController.selectedEmpType,                      
                      validator: empController.empTypeValidator,
                      onChanged: (DropDownValue value) {
                        empController.selectedEmpType = value;
                        empController.employee.employeeType = value.id;
                      }),
            
                  SizedBox(
                    height: kSize.height * 0.040,
                  ),
                  CustomTextField(
                    controller: empController.phoneController,
                    text: AppStrings.phoneText,
                    keyboardType: TextInputType.number,
                    required: true,
                    hintText: AppStrings.phoneHint,
                    validator: empController.phoneValidator,
                    onSave: (val){
                       empController.employee.employeeMobile = val;
                    },
                  ),
                  SizedBox(
                    height: kSize.height * 0.040,
                  ),
                  CustomTextField(
                    controller: empController.emailTextController,
                    text: 'Email',
                    required: true,
                    hintText: 'Email',
                    validator: empController.emailValidator,
                    onSave: (val){
                       empController.employee.email = val;
                    },
                  ),
                  // SizedBox(
                  //   height: kSize.height * 0.040,
                  // ),
                  // const CustomTextField(
                  //   text: AppStrings.phoneText,
                  //   required: true,
                  //   hintText: AppStrings.phoneHint,
                  // ),
                  SizedBox(
                    height: kSize.height * 0.040,
                  ),
                  // Align(alignment: Alignment.centerLeft, child: smallLabelText('Date Of Birth')),
                  CustomTextField(
                    required: true,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        AppImages.calender,
                        colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                      ),
                    ),
                    //  controller: dob,
                    hintText: AppStrings.dobText,
                    text: AppStrings.dobText,
                     validator: empController.dobValidator,
                    onChanged: (value) {
                      controller.changeDate(value);
                    },
                  ),
                  /* DatePickerContainer(
                    changeDate: (v) {
                      controller.changeDate(v);
                    },
                    hintText: 'DOB',
                  ), */
                  SizedBox(
                    height: kSize.height * 0.040,
                  ),
                  CustomTextField(
                    controller: empController.homeContact,
                    text: AppStrings.homeContactText,
                    required: true,
                    keyboardType: TextInputType.number,
                    hintText: AppStrings.homeContactHint,
                    validator: empController.homeContactValidator,
                    onSave: (val){
                       empController.employee.homeContact = val;
                    },
                  ),
                  SizedBox(
                    height: kSize.height * 0.040,
                  ),
                  CustomTextField(
                    controller: empController.addressContactTxtController,
                    text: AppStrings.address,
                    required: true,
                    maxLines: 3,
                    hintText: AppStrings.address,
                    validator: empController.homeContactValidator,
                    onSave: (val){
                       empController.employee.address = val;
                    },
                  ),
                  SizedBox(
                    height: kSize.height * 0.040,
                  ),
                  // idproof(),
                  CommonDropdown(
                      hintText: 'Id Proof',
                      dropDownValue: empController.employeeIdLists,
                      selecteItem: empController.selectedIdType,                      
                      validator: empController.idTypeValidator,
                      onChanged: (DropDownValue value) {
                        empController.selectedIdType = value;
                        empController.employee.idProofType = value.id;
                      }),
                  SizedBox(
                    height: kSize.height * 0.040,
                  ),
                  CustomTextField(
                    controller: empController.idNumberTxtController,
                    text: AppStrings.panCardText,
                    required: true,
                    hintText: AppStrings.panCardText,
                    validator: empController.idNumberValidator,
                    onSave: (val){
                       empController.employee.idProofNumber = val;
                    },
                  ),
                  SizedBox(
                    height: kSize.height * 0.040,
                  ),
                  CustomTextField(
                    controller: empController.bloodGroupController,
                    text: '',
                    required: true,
                    hintText: 'Blood Group',                    
                    onSave: (val){
                       empController.employee.bloodGroup = val;
                    },
                  ),
                  SizedBox(
                    height: kSize.height * 0.040,
                  ),
                  FooterButton(
                    label: 'Add Employee',
                    onTap: () {
                      empController.addEmployee(token: auth.accesToken ?? '', context: context).then((value) => controller.employeeList(token: auth.accesToken ?? ''));
                    },
                  ),
                  SizedBox(
                    height: kSize.height * 0.040,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context, Size kSize) {
    return AppBar(
      elevation: 0,
      leading: const CustomBackButton(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        "Add Employee",
        style: AppTypography.poppinsSemiBold.copyWith(
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }

  Widget uploadProImage(Size kSize) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: AppConstants.basePadding),
          padding: const EdgeInsets.all(AppConstants.marginSpace),
          clipBehavior: Clip.antiAlias,
          height: kSize.height * 0.072,
          width: kSize.height * 0.072,
          decoration: const BoxDecoration(
            color: AppColors.accentColor,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            AppImages.camera,
            colorFilter: const ColorFilter.mode(AppColors.secondaryColor, BlendMode.srcIn),
            // color: AppColors.secondaryColor,
          ),
        ),
        Text(
          AppStrings.takePhotoText,
          style: AppTypography.poppinsMedium.copyWith(
            color: AppColors.secondaryColor,
            fontSize: 14,
          ),
        )
      ],
    );
  }

  Widget idproof() {
    return CustomDropdownSearch(
      label: "ID Proof",
      required: true,
      items: const ['Aadhaar Card', 'Driving Licence', "Voter ID"],
      hintText: AppStrings.proofSelectionText,
      // validator: signupState.idProofValidator,
      onSave: (val) {
        // signupState.signupModel.idProof = val;
      },
    );
  }
}

Widget smallLabelText(String label, {double? topPadding, double bottomPadding = 5, bool isRequired = false}) {
  return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding, top: topPadding ?? 15),
      child: RichText(
        text: TextSpan(text: label, style: const TextStyle(), children: [
          if (isRequired)
            const TextSpan(
                text: ' *', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 15))
        ]),
      )
      // Text(label,
      //     style: isRequired
      //         ? smallLabelStyle.copyWith(color: redColor)
      //         : smallLabelStyle),
      );
}
