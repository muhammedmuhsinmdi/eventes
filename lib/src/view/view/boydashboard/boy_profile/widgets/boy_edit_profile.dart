import 'package:evantez/src/view/core/constants/constants.dart';
import 'package:evantez/src/view/core/widgets/custom_back_btn.dart';
import 'package:evantez/src/view/core/widgets/custom_textfield.dart';
import 'package:evantez/src/view/core/widgets/footer_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/typography.dart';

class BoyEditProfile extends StatelessWidget {
  BoyEditProfile({super.key});

  final TextEditingController name = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController bloodgroup = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController homeContact = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController accountNo = TextEditingController();
  final TextEditingController ifsc = TextEditingController();
  final TextEditingController bank = TextEditingController();
  final TextEditingController branch = TextEditingController();
  final TextEditingController upiId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, kSize),
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  required: true,
                  controller: name,
                  hintText: AppStrings.fillNameHint,
                  text: AppStrings.nameText,
                  onChanged: (value) {
                    //
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: kSize.height * 0.016, top: kSize.height * 0.024),
                  child: Divider(
                    color: AppColors.secondaryColor.withOpacity(0.3),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: kSize.height * 0.016),
                  child: Text(
                    AppStrings.personalInfoText,
                    style:
                        AppTypography.poppinsSemiBold.copyWith(fontSize: 18, color: AppColors.secondaryColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: kSize.height * 0.016),
                  child: CustomTextField(
                    required: true,
                    controller: dob,
                    hintText: AppStrings.dobText,
                    text: AppStrings.dobText,
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: kSize.height * 0.016),
                  child: CustomTextField(
                    required: true,
                    controller: bloodgroup,
                    hintText: AppStrings.bloodGroup,
                    text: AppStrings.bloodGroup,
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: kSize.height * 0.016),
                  child: CustomTextField(
                    required: true,
                    controller: phone,
                    hintText: AppStrings.phoneHint,
                    text: AppStrings.phoneText,
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: kSize.height * 0.016),
                  child: CustomTextField(
                    required: true,
                    controller: homeContact,
                    hintText: AppStrings.homeContactText,
                    text: AppStrings.homeContactText,
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
                CustomTextField(
                  required: true,
                  maxLines: 3,
                  controller: address,
                  hintText: AppStrings.address,
                  text: AppStrings.address,
                  onChanged: (value) {
                    //
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kSize.height * 0.024),
                  child: Divider(
                    color: AppColors.secondaryColor.withOpacity(0.3),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: kSize.height * 0.016),
                  child: CustomTextField(
                    controller: email,
                    hintText: AppStrings.email,
                    text: AppStrings.email,
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kSize.height * 0.024),
                  child: Divider(
                    color: AppColors.secondaryColor.withOpacity(0.3),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: kSize.height * 0.016),
                  child: Text(
                    AppStrings.paymentDetailsText,
                    style:
                        AppTypography.poppinsSemiBold.copyWith(fontSize: 18, color: AppColors.secondaryColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kSize.height * 0.016),
                  child: Text(
                    'Bank Details',
                    style: AppTypography.poppinsMedium.copyWith(
                      color: AppColors.secondaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: kSize.height * 0.016),
                  child: CustomTextField(
                    controller: accountNo,
                    hintText: AppStrings.accountNoText,
                    text: AppStrings.accountNoText,
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: kSize.height * 0.016),
                  child: CustomTextField(
                    controller: ifsc,
                    text: AppStrings.ifscCodeText,
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: kSize.height * 0.016),
                  child: CustomTextField(
                    text: "Bank",
                    controller: bank,
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: kSize.height * 0.016),
                  child: CustomTextField(
                    controller: branch,
                    text: "Branch",
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kSize.height * 0.024),
                  child: Divider(
                    color: AppColors.secondaryColor.withOpacity(0.3),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: kSize.height * 0.024),
                  child: CustomTextField(
                    text: "UPI Id",
                    controller: upiId,
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
                FooterButton(
                    label: "Save",
                    onTap: () {
                      //
                    }),
                SizedBox(
                  height: kSize.height * 0.032,
                )
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
        AppStrings.editProfileText,
        style: AppTypography.poppinsSemiBold.copyWith(
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }
}
