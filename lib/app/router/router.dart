import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/model/core/models/menu/menu_model.dart';
import 'package:evantez/src/model/core/models/signin/pm_signin.dart';
import 'package:evantez/src/view/view/admin/catering/food_items/widgets/food_item_filter.dart';
import 'package:evantez/src/view/view/admin/resouces/employee/add_employee_view/add_employee_view.dart';
import 'package:evantez/src/view/view/auth/login/login_view.dart';
import 'package:evantez/src/view/view/auth/otp_view/otp_view.dart';
import 'package:evantez/src/view/view/auth/sign_up/sign_up_view.dart';
import 'package:evantez/src/view/view/boys/boydashboard/boy_event_detail_view/boy_event_detail_view.dart';
import 'package:evantez/src/view/view/boys/boydashboard/boy_dashboard_view.dart';
import 'package:evantez/src/view/view/boys/boydashboard/boy_profile/widgets/boy_edit_profile.dart';
import 'package:evantez/src/view/view/boys/boydashboard/notification_view/boy_notification_view.dart';
import 'package:evantez/src/view/view/admin/catering/food_items/food_items.dart';
import 'package:evantez/src/view/view/admin/catering/food_quotes/food_quotes_view.dart';
import 'package:evantez/src/view/view/common/messages/admin_amount_received.dart';
import 'package:evantez/src/view/view/common/messages/boy_early_exit.dart';
import 'package:evantez/src/view/view/common/messages/boy_event_remove.dart';
import 'package:evantez/src/view/view/common/messages/boy_exit_record.dart';
import 'package:evantez/src/view/view/common/messages/boy_settled_success.dart';
import 'package:evantez/src/view/view/admin/dashboard/dashboard_view.dart';
import 'package:evantez/src/view/view/admin/dashboard/event_detail_view/widgets/applied_completed.dart';
import 'package:evantez/src/view/view/admin/reports/day_book/day_book_report.dart';
import 'package:evantez/src/view/view/admin/reports/employee_dues/employee_dues_report.dart';
import 'package:evantez/src/view/view/admin/reports/event_dues/event_dues_report.dart';
import 'package:evantez/src/view/view/admin/reports/event_profit/employee_profit_report.dart';
import 'package:evantez/src/view/view/admin/resouces/employee/employee_application_view/employee_application_view.dart';
import 'package:evantez/src/view/view/admin/resouces/employee/employee_list_view/employee_list_view.dart';
import 'package:evantez/src/view/view/admin/resouces/employee/employee_view/employee_view.dart';
import 'package:evantez/src/view/view/admin/dashboard/event_detail_view/emp_performace/emp_performance.dart';
import 'package:evantez/src/view/view/admin/dashboard/event_detail_view/event_detail_view.dart';
import 'package:evantez/src/view/view/admin/dashboard/notification_view/notificaton_view.dart';
import 'package:evantez/src/view/view/admin/resouces/employee_type/employee_type_view.dart';
import 'package:evantez/src/view/view/admin/resouces/rental_items/rental_items_view.dart';
import 'package:evantez/src/view/view/admin/resouces/settings_wage/settings_wage_view.dart';
import 'package:evantez/src/view/view/splash/splash_view.dart';
import 'package:evantez/src/view/view/admin/transactions/invoice/invoice_detail_view/invoice_detail_view.dart';
import 'package:evantez/src/view/view/admin/transactions/invoice/invoices/invoices_view.dart';
import 'package:evantez/src/view/view/admin/transactions/invoice/new_invoice/new_invoice_view.dart';
import 'package:evantez/src/view/view/admin/transactions/new_event/new_event.dart';
import 'package:evantez/src/view/view/admin/transactions/payment/payment_view/new_payment_view.dart';
import 'package:evantez/src/view/view/admin/transactions/quotation/new_quotations_view.dart';
import 'package:evantez/src/view/view/admin/transactions/quotation/quotation_detail_view.dart';
import 'package:evantez/src/view/view/admin/transactions/quotation/quotations.dart';
import 'package:flutter/material.dart';
import '../../src/view/view/admin/catering/food_quotes/new_food_quotes.dart';
import '../../src/view/view/common/messages/admin_supervisor_marked.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterConstants.splashRoute:
        return MaterialPageRoute<SplashView>(
          builder: (_) => const SplashView(),
        );
      case RouterConstants.loginRoute:
        return MaterialPageRoute<LoginView>(
          builder: (_) => LoginView(),
        );
      case RouterConstants.registerRoute:
        return MaterialPageRoute<SignUpView>(
          builder: (_) => SignUpView(),
        );
      case RouterConstants.otpRoute:
        final args = settings.arguments as PhonVerfiyModel;
        return MaterialPageRoute<SignUpView>(
          builder: (_) => OTPView(phonVerfy: args),
        );
      case RouterConstants.dashboardRoute:
        return MaterialPageRoute<DashBoardView>(
          builder: (_) => const DashBoardView(),
        );
      case RouterConstants.boysDashboardRoute:
        return MaterialPageRoute<BoyDashBoardView>(
          builder: (_) => const BoyDashBoardView(),
        );
      case RouterConstants.newPaymentRoute:
        return MaterialPageRoute<NewPaymentView>(
          builder: (_) => NewPaymentView(),
        );
      case RouterConstants.newEventRoute:
        return MaterialPageRoute<NewEventView>(
          builder: (_) => NewEventView(),
        );

      case RouterConstants.employeeListRoute:
        return MaterialPageRoute<EmployeeListView>(
          builder: (_) => const EmployeeListView(),
        );
      case RouterConstants.employeeDetailViewRoute:
        return MaterialPageRoute<EmployeeDetailView>(
          builder: (_) => EmployeeDetailView(),
        );
      case RouterConstants.addEmployeeViewRoute:
        return MaterialPageRoute<AddEmployeeView>(
          builder: (_) => const AddEmployeeView(),
        );
      case RouterConstants.empApplicationRoute:
        return MaterialPageRoute<EmployeeApplicationView>(
          builder: (_) => const EmployeeApplicationView(),
        );
      case RouterConstants.employeeTypeRoute:
        final ags = settings.arguments as MenuData;
        return MaterialPageRoute<EmployeeTypeView>(
          builder: (_) => EmployeeTypeView(
            menu: ags,
          ),
        );
      case RouterConstants.settingsWageRoute:
        final args = settings.arguments as MenuData;
        return MaterialPageRoute<SettingsWageView>(
          builder: (_) => SettingsWageView(menu: args),
        );
      case RouterConstants.rentalItemsRoute:
        final args = settings.arguments as MenuData;
        return MaterialPageRoute<RentalItemsView>(
          builder: (_) => RentalItemsView(menu: args),
        );
      case RouterConstants.eventDetailRoute:
        // final args = settings.arguments as MenuData;
        return MaterialPageRoute<EventDetailView>(
          builder: (_) => const EventDetailView(),
        );
      case RouterConstants.invoiceRoute:
        final args = settings.arguments as MenuData;
        return MaterialPageRoute<InvoicesView>(
          builder: (_) => InvoicesView(menu: args),
        );
      case RouterConstants.newInvoiceRoute:
        // final args = settings.arguments as MenuData;
        return MaterialPageRoute<NewInvoiceView>(
          builder: (_) => const NewInvoiceView(),
        );
      case RouterConstants.invoiceDetailRoute:
        // final args = settings.arguments as MenuData;
        return MaterialPageRoute<InvoiceDetailView>(
          builder: (_) => const InvoiceDetailView(),
        );

      case RouterConstants.empPerformanceRoute:
        final args = settings.arguments as String;
        return MaterialPageRoute<EmployeePerformanceView>(
          builder: (_) => EmployeePerformanceView(eventStatus: args),
        );
      case RouterConstants.notificationRoute:
        return MaterialPageRoute<NotificationView>(
          builder: (_) => const NotificationView(),
        );
      case RouterConstants.newQuotationRoute:
        return MaterialPageRoute<NewQuotationView>(
          builder: (_) => const NewQuotationView(),
        );
      case RouterConstants.quotationRoute:
        return MaterialPageRoute<QuotationsView>(
          builder: (_) => const QuotationsView(),
        );
      case RouterConstants.quotationDetailRoute:
        return MaterialPageRoute<QuotationDetailView>(
          builder: (_) => const QuotationDetailView(),
        );
      case RouterConstants.eventProfitRoute:
        return MaterialPageRoute<EventProfitReport>(
          builder: (_) => const EventProfitReport(),
        );
      case RouterConstants.eventDuesRoute:
        return MaterialPageRoute<EventDuesReport>(
          builder: (_) => const EventDuesReport(),
        );
      case RouterConstants.employeeDuesRoute:
        return MaterialPageRoute<EmployeeDuesReport>(
          builder: (_) => const EmployeeDuesReport(),
        );
      case RouterConstants.dayBookRoute:
        return MaterialPageRoute<DayBookReport>(
          builder: (_) => const DayBookReport(),
        );
      case RouterConstants.foodItemRoute:
        final args = settings.arguments as MenuData;
        return MaterialPageRoute<FoodItemsView>(
          builder: (_) => FoodItemsView(menu: args),
        );
      case RouterConstants.addFoodItemRoute:
        final args = settings.arguments as int;
        return MaterialPageRoute<FoodItemFilter>(
          builder: (_) => FoodItemFilter(index: args),
        );
      case RouterConstants.foodQuotesRoute:
        return MaterialPageRoute<FoodQuotesView>(
          builder: (_) => const FoodQuotesView(),
        );
      case RouterConstants.newFoodQuotesRoute:
        return MaterialPageRoute<NewFoodQuotesView>(
          builder: (_) => const NewFoodQuotesView(),
        );

      // Success Route
      case RouterConstants.boysSettleRoute:
        return MaterialPageRoute<BoySettledSuccess>(
          builder: (_) => const BoySettledSuccess(),
        );
      case RouterConstants.boyExitRecordRoute:
        return MaterialPageRoute<BoyExitRecord>(
          builder: (_) => const BoyExitRecord(),
        );
      case RouterConstants.boyEarlyExitRoute:
        return MaterialPageRoute<BoyEarlyExit>(
          builder: (_) => const BoyEarlyExit(),
        );
      case RouterConstants.adminAmtReceievedRoute:
        return MaterialPageRoute<AdminAmoutRecieved>(
          builder: (_) => const AdminAmoutRecieved(),
        );
      case RouterConstants.admineventRemoveBoyRoute:
        return MaterialPageRoute<BoyEventRemove>(
          builder: (_) => const BoyEventRemove(),
        );
      case RouterConstants.supervisorMarked:
        return MaterialPageRoute<AdminSuperVisorMarked>(
          builder: (_) => const AdminSuperVisorMarked(),
        );
      case RouterConstants.boyNotificationRoute:
        return MaterialPageRoute<BoyNotificationView>(
          builder: (_) => const BoyNotificationView(),
        );
      case RouterConstants.boyEventDetailRoute:
        return MaterialPageRoute<BoyEventDetailView>(
          builder: (_) => const BoyEventDetailView(),
        );
      case RouterConstants.boyEditProfileRoute:
        return MaterialPageRoute<BoyEditProfile>(
          builder: (_) => BoyEditProfile(),
        );
      case RouterConstants.applystatus:
        return MaterialPageRoute<ApplyCompleted>(
          builder: (_) => const ApplyCompleted(),
        );

      default:
        return MaterialPageRoute<Scaffold>(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
