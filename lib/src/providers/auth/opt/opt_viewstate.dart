import 'package:evantez/src/model/repository/auth/auth_repository.dart';
import 'package:evantez/src/model/services/services.dart';
import 'package:flutter/material.dart';

class OtpViewstate extends ChangeNotifier {
  late IAuthRepository authRepository;
  OtpViewstate(){
    authRepository = Services.authRepository;
  }

  Future otpVerify(String otp) async => await authRepository.otpVerify(otp);
}