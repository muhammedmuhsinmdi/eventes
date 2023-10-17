// import 'dart:developer';

// import 'package:evantez/app/router/router_constant.dart';
// import 'package:evantez/src/model/repository/auth/auth_repository.dart';
// import 'package:evantez/src/model/core/models/signin/pm_signin.dart';
// import 'package:evantez/src/model/services/services.dart';
// import 'package:evantez/src/providers/auth/login/models/authresponse.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class LoginViewState extends ChangeNotifier {
//   late IAuthRepository authRepository;
//   LoginViewState() {
//     authRepository = Services.authRepository;
//   }

//   final bool _isLoading = false;
//   bool get isLoading => _isLoading;
//   set isloading(value) {
//     isloading = value;
//   }

//   late PmSignin _pmSignin = PmSignin(phone: "");
//   PmSignin get pmSignin => _pmSignin;
//   set pmSignin(PmSignin val) {
//     _pmSignin = val;
//     notifyListeners();
//   }

//   String? phoneValidator(String? value) {
//     if (value == null || value.isEmpty) {
//       return "Required Field..";
//     } else {
//       return null;
//     }
//   }

//   // Future login(BuildContext context) async {
//   //   log(pmSignin.phone!);
//   //   await FirebaseAuth.instance.verifyPhoneNumber(
//   //       phoneNumber: '+91${pmSignin.phone}',
//   //       verificationCompleted: (PhoneAuthCredential credential) {
          
//   //       },
//   //       verificationFailed: (FirebaseAuthException e) {},
//   //       codeSent: (String verificationId, int? resendToken) {
//   //         log(verificationId);
//   //         log("$resendToken");
//   //         var phoneVerify = PhonVerfiyModel(verificationId: verificationId, resendToken: resendToken);
//   //         navigate(context, RouterConstants.otpRoute, arg: phoneVerify);
//   //       },
//   //       codeAutoRetrievalTimeout: (String verificationId) {});
//   // }
//   // //  => await authRepository.login(pmSignin);

//   // navigate(BuildContext context, String router, {dynamic arg}) {
//   //   Navigator.pushNamed(context, router, arguments: arg);
//   // }
//  AuthResponse? authResponse;
//   String? _accesToken;

//   String? get accesToken => _accesToken;

//   set accesToken(String? accesToken) {
//     _accesToken = accesToken;
//     notifyListeners();
//   }

//   Future<dynamic> login(BuildContext context, 
//      ) async {
//     try {
  
//       authResponse = null;
//       final response = await TGPYBookAuthApi().login(
//           email: signInEmailController.text.trim(),
//           password: signInPasswordController.text.trim());
//       if (response.runtimeType == ErrorResponse) {
//         Navigator.pop(context);
//         return rootScaffoldMessengerKey.currentState?.showSnackBar(
//           snackBarWidget((response as ErrorResponse).detail!),
//         );
//       } else if ((response as AuthResponse).accessToken != null) {
//         authResponse = response;
//         if (isRememberMe) {
//           SharedPreferences sharedPreferences =
//               await SharedPreferences.getInstance();
//           sharedPreferences.setString('accessToken', response.accessToken!);
//           accesToken = sharedPreferences.getString('accessToken')!;
//           Map<String, dynamic> decodedToken =
//               JwtDecoder.decode(response.accessToken!);
//           userId = decodedToken['user_id'];
//           sharedPreferences.setString('userId', userId.toString());
//         } else {
//           accesToken = response.accessToken;
//           Map<String, dynamic> decodedToken =
//               JwtDecoder.decode(response.accessToken!);
//           userId = decodedToken['user_id'];
//         }
//         signInEmailController.clear();
//         signInPasswordController.clear();
//         homeController.initStateOfDashBoard(accesToken ?? '',
//             authController: authController, context: context);
//         Navigator.pushNamedAndRemoveUntil(
//             context, HomeDashBoard.routeName, (route) => false);
//       }
//     } catch (e) {
//       Navigator.pop(context);
//     }
//   }
// }
