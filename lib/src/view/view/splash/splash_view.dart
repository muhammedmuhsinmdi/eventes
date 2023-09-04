import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/model/core/app_prefs/app_prefs.dart';
import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    navigate(context);
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SizedBox(
            height: kSize.height,
            width: kSize.width,
            child: Center(
              child: SizedBox(
                height: kSize.height * 0.1,
                width: kSize.width * 0.45,
                child: Image.asset(
                  AppImages.appLogo,
                  fit: BoxFit.contain,
                  height: kSize.height * 0.1,
                  width: kSize.width * 0.4,
                ),
              ),
            )));
  }

  navigate(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    await AppPrefs.readLocalCaches();
    if (AppPrefs.token != null && AppPrefs.token!.isNotEmpty) {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, RouterConstants.dashboardRoute);
      }
    } else {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, RouterConstants.loginRoute);
      }
    }
  }
}
