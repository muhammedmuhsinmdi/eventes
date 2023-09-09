// import 'package:evantez/src/model/repository/auth/auth_repository.dart';
// import 'package:evantez/src/model/core/extensions/validation_extension.dart';
// import 'package:evantez/src/model/core/models/signup/pm_signup_model.dart';
// import 'package:evantez/src/model/services/services.dart';
// import 'package:flutter/material.dart';

// class SignupViewState extends ChangeNotifier {
//   late IAuthRepository authRepository;
//   final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

//   SignupViewState() {
//     authRepository = Services.authRepository;
//   }

//   late SignupModel _signupModel = SignupModel();
//   SignupModel get signupModel => _signupModel;
//   set signupModel(SignupModel val) {
//     _signupModel = val;
//     notifyListeners();
//   }

//   Future signUp() async {
//     if (signupFormKey.currentState!.validate()) {
//       signupFormKey.currentState!.save();
//       return await authRepository.signUp(signupModel);
//     }
//   }

//   // validators
//   String? fullNameValidator(String? value) {
//     if (value!.isEmpty) {
//       return "Required Field..";
//     } else {
//       return null;
//     }
//   }

//   String? phoneValidator(String? value) {
//     if (value!.isEmpty) {
//       return "Required Field..";
//     } else {
//       return null;
//     }
//   }

//   String? homeContactValidator(String? value) {
//     if (value!.isEmpty) {
//       return "Required Field..";
//     } else {
//       return null;
//     }
//   }

//   String? dobValidator(String? value) {
//     if (value!.isEmpty) {
//       return "Required Field..";
//     } else {
//       return null;
//     }
//   }

//   String? addressValidator(String? value) {
//     if (value!.isEmpty) {
//       return "Required Field..";
//     } else {
//       return null;
//     }
//   }

//   String? emailValidator(String? value) {
//     if (value!.isNotEmpty) {
//       if (value.isValidEmail()) {
//         return null;
//       } else {
//         return "Please enter valid email id";
//       }
//     }
//     return null;
//   }

//   String? idProofValidator(String? value) {
//     if (value == null) {
//       return "Required Field..";
//     } else {
//       return null;
//     }
//   }

//   String? idNumberValidator(String? value) {
//     if (value!.isEmpty) {
//       return "Required Field..";
//     } else {
//       return null;
//     }
//   }
// }