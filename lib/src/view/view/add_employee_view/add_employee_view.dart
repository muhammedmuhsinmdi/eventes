import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//widgets/custom_dropdown_search.dart';
import 'package:evantez/src/view/core//widgets/custom_textfield.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/app_strings.dart';
import '../../core/themes/typography.dart';
import '../../core/widgets/custom_back_btn.dart';

class AddEmployeeView extends StatelessWidget {
  const AddEmployeeView({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: [
                uploadProImage(kSize),
                SizedBox(
                  height: kSize.height * 0.040,
                ),
                const CustomTextField(
                  text: AppStrings.fullNameText,
                  required: true,
                  hintText: "Enter ${AppStrings.fullNameText}",
                ),
                SizedBox(
                  height: kSize.height * 0.040,
                ),
                const CustomDropdownSearch(
                  label: AppStrings.employeeTypeText,
                  hintText: 'Select Employee Type',
                  required: true,
                  items: ["Head", "Supervisor", "Captain"],
                ),
                SizedBox(
                  height: kSize.height * 0.040,
                ),
                const CustomTextField(
                  text: AppStrings.phoneText,
                  required: true,
                  hintText: AppStrings.phoneHint,
                ),
                SizedBox(
                  height: kSize.height * 0.040,
                ),
                const CustomTextField(
                  text: AppStrings.phoneText,
                  required: true,
                  hintText: AppStrings.phoneHint,
                ),
                SizedBox(
                  height: kSize.height * 0.040,
                ),
                const CustomTextField(
                  text: AppStrings.homeContactText,
                  required: true,
                  hintText: AppStrings.homeContactHint,
                ),
                SizedBox(
                  height: kSize.height * 0.040,
                ),
                const CustomTextField(
                  text: AppStrings.address,
                  required: true,
                  maxLines: 3,
                  hintText: AppStrings.address,
                ),
                SizedBox(
                  height: kSize.height * 0.040,
                ),
                idproof(),
                SizedBox(
                  height: kSize.height * 0.040,
                ),
                const CustomTextField(
                  text: AppStrings.panCardText,
                  required: true,
                  hintText: AppStrings.panCardText,
                ),
                SizedBox(
                  height: kSize.height * 0.040,
                ),
                FooterButton(
                  label: 'Add Employee',
                  onTap: () {
                    //
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
    );
  }

  AppBar appBar(BuildContext context, Size kSize) {
    return AppBar(
      elevation: 0,
      leading: const CustomBackButton(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        AppStrings.employeeListText,
        style: AppTypography.poppinsSemiBold.copyWith(),
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
