import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/model/core/enums/enum.dart';

class MenuData {
  String? menuName;
  String? routeUrl;
  int? menuOrder;
  MenuType? menuType;

  MenuData({this.menuName, this.routeUrl, this.menuOrder, this.menuType});
}

List<MenuData> menus = [
  // transaction
  MenuData(
      menuName: "Quotations",
      menuOrder: 1,
      menuType: MenuType.transaction,
      routeUrl: RouterConstants.quotationRoute),
  MenuData(
      menuName: "New Event",
      menuOrder: 2,
      menuType: MenuType.transaction,
      routeUrl: RouterConstants.newEventRoute),
  MenuData(
      menuName: "Invoices",
      menuOrder: 3,
      menuType: MenuType.transaction,
      routeUrl: RouterConstants.invoiceRoute),
  MenuData(
      menuName: "Payment",
      menuOrder: 4,
      menuType: MenuType.transaction,
      routeUrl: RouterConstants.newPaymentRoute),
  //resources
  MenuData(
    menuName: "Employees",
    menuOrder: 1,
    menuType: MenuType.resources,
    routeUrl: RouterConstants.employeeListRoute,
  ),
  MenuData(
    menuName: "Employee Types",
    menuOrder: 2,
    menuType: MenuType.resources,
    routeUrl: RouterConstants.employeeTypeRoute,
  ),
  MenuData(
    menuName: "Rental Items",
    menuOrder: 3,
    menuType: MenuType.resources,
    routeUrl: RouterConstants.rentalItemsRoute,
  ),
  MenuData(
    menuName: "Settings Wage",
    menuOrder: 4,
    menuType: MenuType.resources,
    routeUrl: RouterConstants.settingsWageRoute,
  ),
  // Reports
  MenuData(
      menuName: "Event Profit",
      menuOrder: 1,
      menuType: MenuType.reports,
      routeUrl: RouterConstants.eventProfitRoute),
  MenuData(
      menuName: "Employee Dues",
      menuOrder: 2,
      menuType: MenuType.reports,
      routeUrl: RouterConstants.employeeDuesRoute),
  MenuData(
      menuName: "Event Dues",
      menuOrder: 3,
      menuType: MenuType.reports,
      routeUrl: RouterConstants.eventDuesRoute),
  MenuData(
    menuName: "Day Book",
    menuOrder: 4,
    menuType: MenuType.reports,
    routeUrl: RouterConstants.dayBookRoute,
  ),
  //Catering
  MenuData(
      menuName: "Food Quotes",
      menuOrder: 1,
      menuType: MenuType.catering,
      routeUrl: RouterConstants.foodQuotesRoute),
  MenuData(
      menuName: "Food Items",
      menuOrder: 2,
      menuType: MenuType.catering,
      routeUrl: RouterConstants.foodItemRoute),
];
