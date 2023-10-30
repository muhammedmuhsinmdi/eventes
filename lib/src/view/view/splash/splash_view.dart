import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/controller/events/events_controller.dart';
import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:evantez/src/controller/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    loadCurrentUser(context);
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

  Future<void> loadCurrentUser(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      EventController eventController = Provider.of<EventController>(context, listen: false);
      NavigatorState navigator = Navigator.of(context);
      AuthController authController = Provider.of<AuthController>(context, listen: false);

      if (await authController.loadCurrentUser() != null) {
        await eventController.events(authController.accesToken ?? '').then((value) async {
          await eventController.getEventVenues(authController.accesToken ?? '');
        });
        navigator.popAndPushNamed(RouterConstants.dashboardRoute);
      } else {
        navigator.popAndPushNamed(RouterConstants.loginRoute);
      }
    });
  }
}
