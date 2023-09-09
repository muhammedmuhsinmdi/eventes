// import 'dart:developer';

// import 'package:evantez/src/model/core/models/signin/pm_signin.dart';
// import 'package:evantez/src/model/core/models/signup/pm_signup_model.dart';
// import 'package:evantez/src/model/helper/http_helper/http_base_helper.dart';

// abstract class IAuthRepository {
//   Future login(PmSignin model);
//   Future signUp(SignupModel model);
//   Future otpVerify(String otp);
// }

// class AuthRepository implements IAuthRepository {
//   ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
//   @override
//   Future login(PmSignin model) async{
//     var data = await _apiBaseHelper.get('token');
    
//     return "Ok";
//   }
  
//   @override
//   Future signUp(SignupModel model) async{
//     log(">>>>>>>>> ${model.toJson()} <<<<<<<<<<<");
//     return "Ok";
//   }
  
//   @override
//   Future otpVerify(String otp) async{
//     if(otp == '121212'){
//       return "Ok";
//     } else {
//       return "Invalid otp";
//     }    
//   }


  
// }