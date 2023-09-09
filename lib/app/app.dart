import 'package:evantez/app/router/router.dart';
import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/model/repository/events/events_controller.dart';
import 'package:evantez/src/providers/auth/login/login_viewstate.dart';
import 'package:evantez/src/providers/auth/opt/opt_viewstate.dart';
import 'package:evantez/src/providers/auth/signup/signup_viewstate.dart';
import 'package:evantez/src/providers/resources/employee_type/employee_type_viewstate.dart';
import 'package:evantez/src/model/repository/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../src/view/core//constants/app_strings.dart';
import '../src/view/core//themes/theme.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => SignupViewState()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        // ChangeNotifierProvider(create: (_) => OtpViewstate()),
        ChangeNotifierProvider(create: (_) => EmployeeTypeViewstate()),
        ChangeNotifierProvider(create: (_) => EventController())
      ],
      child: MaterialApp(
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        title: AppStrings.appName,
        theme: AppThemes.darkTheme,
        darkTheme: AppThemes.darkTheme,
        initialRoute: RouterConstants.splashRoute,
        onGenerateRoute: AppRouter.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
