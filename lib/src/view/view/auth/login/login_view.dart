import 'dart:developer';

import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/providers/auth/login/login_viewstate.dart';
import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:evantez/src/view/core//constants/app_strings.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:evantez/src/view/core//widgets/custom_textfield.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  late LoginViewState loginState;
  final ValueNotifier<bool> isloading = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    loginState = Provider.of<LoginViewState>(context);
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            AppStrings.loginText,
            style: AppTypography.poppinsSemiBold.copyWith(
              fontSize: 22,
              color: AppColors.secondaryColor,
            ),
          )),
      body: Form(
        key: formKey,
        child: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(AppImages.appLogo),
                const Spacer(),
                CustomTextField(
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  text: AppStrings.phoneText,
                  hintText: AppStrings.phoneHint,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      AppImages.call,
                      colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                    ),
                  ),
                  validator: loginState.phoneValidator,
                  onSave: (value) {
                    loginState.pmSignin.phone = value;
                  },
                  controller: phoneController,
                ),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
                ValueListenableBuilder(
                    valueListenable: isloading,
                    builder: (context, value, child) {
                      if (value) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        );
                      } else {
                        return FooterButton(
                          label: AppStrings.loginText,
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              isloading.value = true;
                              var result = await loginState.login(context);
                              // log(result);
                              // if (result == "Ok") {
                              //   if (context.mounted) {
                              //     navigate(context, RouterConstants.bottomNavRoute);
                              //   }
                              // } else {}
                            }
                          },
                        );
                      }
                    }),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                RichText(
                    text: TextSpan(
                        text: AppStrings.registerUser,
                        style: AppTypography.poppinsMedium
                            .copyWith(color: AppColors.secondaryColor.withOpacity(0.4)),
                        children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => loginState.navigate(context, RouterConstants.registerRoute),
                          text: "  ${AppStrings.signUpText}",
                          style: AppTypography.poppinsMedium.copyWith(color: AppColors.primaryColor))
                    ])),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
