import 'package:evantez/app/router/router.dart';
import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/controller/events/add_event_controller.dart';
import 'package:evantez/src/controller/events/event_type_controller.dart';
import 'package:evantez/src/controller/events/events_controller.dart';
import 'package:evantez/src/controller/catering/food_items_repository.dart';
import 'package:evantez/src/controller/events/new_event_venue_controller.dart';
import 'package:evantez/src/controller/resources/employee/add_employee_controller.dart';
import 'package:evantez/src/controller/resources/employee/employee_controller.dart';
import 'package:evantez/src/controller/resources/rentalitem_controller.dart';
import 'package:evantez/src/controller/resources/settingswages_controller.dart';
import 'package:evantez/src/controller/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../src/view/core//constants/app_strings.dart';
import '../src/view/core//themes/theme.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => SignupViewState()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        // ChangeNotifierProvider(create: (_) => OtpViewstate()),
        ChangeNotifierProvider(create: (_) => AddEmployeeController()),
        ChangeNotifierProvider(create: (_) => EmployeesController()),
        ChangeNotifierProvider(create: (_) => EventController()),
        ChangeNotifierProvider(create: (_) => SettingsWageController()),
        ChangeNotifierProvider(create: (_) => RentalItemsController()),
        ChangeNotifierProvider(create: (_) => FoodItemsController()),
        ChangeNotifierProvider(create: (_) => AddEventController()),
        ChangeNotifierProvider(create: (_) => EventVenueController()),
        ChangeNotifierProvider(create: (_) => EventTypeController()),
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
