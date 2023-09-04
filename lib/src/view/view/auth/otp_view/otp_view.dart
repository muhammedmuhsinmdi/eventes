import 'dart:developer';

import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/providers/auth/opt/opt_viewstate.dart';
import 'package:evantez/src/model/core/app_prefs/app_prefs.dart';
import 'package:evantez/src/model/core/models/signin/pm_signin.dart';
import 'package:evantez/src/view/core/constants/constants.dart';
import 'package:evantez/src/view/view/auth/otp_view/widgets/otp_filed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/themes/colors.dart';
import '../../../core/themes/typography.dart';
import '../../../core/widgets/footer_button.dart';

class OTPView extends StatefulWidget {
  const OTPView({super.key, required this.phonVerfy});
  final PhonVerfiyModel phonVerfy;
  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final FirebaseAuth auth = FirebaseAuth.instance;
  String otp = '';
  bool isDisable = true;
  final List<TextEditingController> controllers = <TextEditingController>[];
  final List<FocusNode> focusNodes = <FocusNode>[];
  late OtpViewstate otpState;

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    otpState = Provider.of<OtpViewstate>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar(context),
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius),
          child: Column(
            children: [
              Text(
                AppStrings.otpDescriptionText,
                style: AppTypography.poppinsRegular
                    .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.4)),
              ),
              SizedBox(
                height: kSize.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  controllers.add(TextEditingController());
                  focusNodes.add(FocusNode());
                  return OtpField(
                    controller: controllers[index],
                    first: index == 0 ? true : false,
                    last: index == 5 ? true : false,
                    focusNode: focusNodes[index],
                    onChanged: (value) {
                      if (otp.length <= 6) {
                        //for (var controller in controllers) {
                        if (value.isNotEmpty) {
                          if (controllers[index].text.isNotEmpty) {
                            if (index != 5) {
                              FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                            }
                            if (index <= 5) {
                              var sumofText = controllers.fold("", (sum, controller) {
                                return sum + controller.text;
                              });
                              otp = sumofText;
                            }
                          }
                        } else {
                          if (index != 0) {
                            FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                          }
                          if (index >= 0) {
                            var sumofText = controllers.fold("", (sum, controller) {
                              return sum + controller.text;
                            });
                            otp = sumofText;
                          }
                        }

                        if (otp.length == 6) {
                          setState(() {
                            isDisable = false;
                          });
                        } else {
                          setState(() {
                            isDisable = true;
                          });
                        }
                        //}
                      }
                    },
                    isFilled: () {
                      log("sdfsfsdfds");
                    },
                  );
                }),
              ),
              const Spacer(
                flex: 2,
              ),
              ValueListenableBuilder(
                  valueListenable: isLoading,
                  builder: (context, value, child) {
                    if (value) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      );
                    } else {
                      return footerButton();
                    }
                  }),
              SizedBox(
                height: kSize.height * 0.024,
              ),
              resendCodeText(context),
              SizedBox(
                height: kSize.height * 0.024,
              ),
              // const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leadingWidth: 0,
      leading: const SizedBox(
        width: 0,
      ),
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          AppStrings.otpHeaderText,
          style: AppTypography.poppinsSemiBold.copyWith(
            fontSize: 22,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
    );
  }

  Widget footerButton() {
    return FooterButton(
        label: 'Continue',
        isDisable: isDisable,
        onTap: () async {
          var sumofText = controllers.fold("", (sum, controller) {
            return sum + controller.text;
          });
          otp = sumofText;
          if (otp.isNotEmpty && otp.length == 6) {
            isLoading.value = true;
            log(otp);
            PhoneAuthCredential credential =
                PhoneAuthProvider.credential(verificationId: widget.phonVerfy.verificationId, smsCode: otp);
            try {
              var userCredential = await auth.signInWithCredential(credential);
              log("Result >>>>> $userCredential");
              if (userCredential.additionalUserInfo!.isNewUser) {
                log("${userCredential.additionalUserInfo!.isNewUser}");
                if (context.mounted) {
                  Navigator.pushNamed(context, RouterConstants.registerRoute);
                }
              } else {
                String? token = await auth.currentUser!.getIdToken();
                if (token != null) {
                  otpState.otpVerify(token);
                  // AppPrefs.token = token;
                  // AppPrefs.writeLocalCaches();
                  // log(token);
                  // if (context.mounted) {
                  //   Navigator.pushNamed(context, RouterConstants.dashboardRoute);
                  // }
                }
              }
            } catch (e) {
              log("exceptiob ${e.toString()}");
            }
            //var result = await otpState.otpVerify(otp);
            // if (result == "Ok") {
            //   if (context.mounted) {
            //     Navigator.pushReplacementNamed(context, RouterConstants.bottomNavRoute);
            //   }
            // } else {}
          } else {}
        });
  }

  Widget resendCodeText(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: "Didn't receive code? ",
            style: AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor.withOpacity(0.4)),
            children: [
              TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = () => Navigator.pop(context),
                  text: "  ${AppStrings.resendCodeText}",
                  style: AppTypography.poppinsMedium.copyWith(color: AppColors.primaryColor))
            ]));
  }
}
