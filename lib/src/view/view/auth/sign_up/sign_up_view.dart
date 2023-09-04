import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/providers/auth/signup/signup_viewstate.dart';
import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//widgets/custom_back_btn.dart';
import 'package:evantez/src/view/core//widgets/custom_dropdown_search.dart';
import 'package:evantez/src/view/core//widgets/custom_textfield.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/themes/colors.dart';
import '../../../core/themes/typography.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  late SignupViewState signupState;
  @override
  Widget build(BuildContext context) {
    signupState = Provider.of<SignupViewState>(context);
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: const CustomBackButton(),
        title: Text(
          AppStrings.signUpHead,
          style: AppTypography.poppinsSemiBold.copyWith(
            fontSize: 22,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
      body: Form(
        key: signupState.signupFormKey,
        child: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius),
              child: Column(
                children: [
                  SizedBox(
                    height: kSize.height * 0.032,
                  ),
                  uploadProImgage(kSize),
                  SizedBox(
                    height: kSize.height * 0.02,
                  ),
                  fullName(),
                  SizedBox(
                    height: kSize.height * 0.02,
                  ),
                  phoneNumber(),
                  SizedBox(
                    height: kSize.height * 0.02,
                  ),
                  homeContact(),
                  SizedBox(
                    height: kSize.height * 0.02,
                  ),
                  dob(context),
                  SizedBox(
                    height: kSize.height * 0.02,
                  ),
                  email(),
                  SizedBox(
                    height: kSize.height * 0.02,
                  ),
                  address(),
                  SizedBox(
                    height: kSize.height * 0.02,
                  ),
                  idproof(),
                  SizedBox(
                    height: kSize.height * 0.02,
                  ),
                  proofField(),
                  SizedBox(
                    height: kSize.height * 0.02,
                  ),
                  termsConditons(),
                  SizedBox(
                    height: kSize.height * 0.02,
                  ),
                  footerButton(context),
                  SizedBox(
                    height: kSize.height * 0.02,
                  ),
                  loginText(context),
                  SizedBox(
                    height: kSize.height * 0.02,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget uploadProImgage(Size kSize) {
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

  Widget fullName() {
    return CustomTextField(
      required: true,
      text: AppStrings.fullNameText,
      hintText: AppStrings.fillNameHint,
      validator: signupState.fullNameValidator,
      onSave: (val) {
        if (val!.isNotEmpty) {
          signupState.signupModel.fullName = val;
        }
      },
    );
  }

  Widget phoneNumber() {
    return CustomTextField(
      required: true,
      text: AppStrings.phoneText,
      hintText: AppStrings.phoneHint,
      validator: signupState.phoneValidator,
      onSave: (val) {
        if (val!.isNotEmpty) {
          signupState.signupModel.phoneNumber = val;
        }
      },
    );
  }

  Widget homeContact() {
    return CustomTextField(
      required: true,
      text: AppStrings.homeContactText,
      hintText: AppStrings.homeContactHint,
      validator: signupState.homeContactValidator,
      onSave: (val) {
        if (val!.isNotEmpty) {
          signupState.signupModel.homeContact = val;
        }
      },
    );
  }

  Widget dob(
    BuildContext context,
  ) {
    DateTime? dob;
    final dobController = TextEditingController();
    return CustomTextField(
      required: true,
      readOnly: true,
      text: AppStrings.dobText,
      controller: dobController,
      hintText: 'Your Date of Birth',
      onTap: () async {
        dob = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1960),
            lastDate: DateTime(2050));
        if (dob != null) {
          signupState.signupModel.dateOfBirth = dob;
          String formattedDate = DateFormat('yyyy-MM-dd').format(dob!);
          dobController.text = formattedDate;
        }
      },
      suffixIcon: SizedBox(
        height: 32,
        width: 32,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SvgPicture.asset(
            AppImages.calender,
            colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget email() {
    return CustomTextField(
      text: AppStrings.email,
      hintText: 'Enter your Email',
      validator: signupState.emailValidator,
      onSave: (val) {
        if (val!.isNotEmpty) {
          signupState.signupModel.emailId = val;
        }
      },
    );
  }

  Widget address() {
    return CustomTextField(
      text: AppStrings.address,
      maxLines: 2,
      hintText: 'Enter your address',
      required: true,
      validator: signupState.addressValidator,
      onSave: (val) {
        if (val!.isNotEmpty) {
          signupState.signupModel.address = val;
        }
      },
    );
  }

  Widget idproof() {
    return CustomDropdownSearch(
      label: "ID Proof",
      required: true,
      items: const ['Aadhaar Card', 'Driving Licence', "Voter ID"],
      hintText: AppStrings.proofSelectionText,
      validator: signupState.idProofValidator,
      onSave: (val) {
        signupState.signupModel.idProof = val;
      },
    );
  }

  Widget proofField() {
    return CustomTextField(
      text: "ID Number",
      hintText: 'Enter ID Number',
      required: true,
      validator: signupState.idNumberValidator,
      onSave: (val) {
        if (val!.isNotEmpty) {
          signupState.signupModel.idNumber = val;
        }
      },
    );
  }

  Widget termsConditons() {
    return RichText(
        text: TextSpan(
            text: 'By signing up you agree to our ',
            style: AppTypography.poppinsRegular.copyWith(color: AppColors.secondaryColor.withOpacity(0.4)),
            children: [
          TextSpan(
              text: 'Terms & Condition ',
              style: AppTypography.poppinsRegular.copyWith(color: AppColors.secondaryColor)),
          TextSpan(
            text: ' and ',
            style: AppTypography.poppinsRegular.copyWith(color: AppColors.secondaryColor.withOpacity(0.4)),
          ),
          TextSpan(
              text: 'Privacy Policy.*',
              style: AppTypography.poppinsRegular.copyWith(color: AppColors.secondaryColor)),
        ]));
  }

  Widget footerButton(BuildContext context) {
    return FooterButton(
        label: 'Continue',
        onTap: () async {
          if (await signupState.signUp() == "Ok") {
            if (context.mounted) {
              navigate(context, RouterConstants.loginRoute);
            }
          }
        });
  }

  Widget loginText(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: "Already have an account? ",
            style: AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor.withOpacity(0.4)),
            children: [
          TextSpan(
              recognizer: TapGestureRecognizer()..onTap = () => Navigator.pop(context),
              text: "  ${AppStrings.loginText}",
              style: AppTypography.poppinsMedium.copyWith(color: AppColors.primaryColor))
        ]));
  }
}

navigate(BuildContext context, String router) {
  Navigator.pushNamed(context, router);
}
