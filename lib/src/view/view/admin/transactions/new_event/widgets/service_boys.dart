import 'dart:developer';

import 'package:evantez/src/controller/auth/auth_controller.dart';
import 'package:evantez/src/controller/resources/employee/employee_controller.dart';
import 'package:evantez/src/controller/transaction/new_event/new_event_controller.dart';
import 'package:evantez/src/model/core/models/event/event_service_boys/event_service_boys_model.dart';
import 'package:evantez/src/model/core/models/event/event_site_emp_requirement/event_site_emp_req_model.dart';
import 'package:evantez/src/model/core/models/event/event_type/event_type_model.dart';
import 'package:evantez/src/model/core/models/event/new_event_model/new_event_model.dart';
import 'package:evantez/src/model/core/models/event_site/event_site_model.dart';
import 'package:evantez/src/serializer/models/employee/employee_types_response.dart';
import 'package:evantez/src/view/view/admin/transactions/new_event/widgets/custom_service_counter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/themes/colors.dart';
import '../../../../../core/widgets/footer_button.dart';

class ServiceBoys extends StatefulWidget {
  final List<EmployeesTypesList> items;
  final EmployeesController employeesController;
  final Function(List<EventSiteEmployeeReqModel>) onSelected;
  const ServiceBoys(
      {super.key, required this.items, required this.onSelected, required this.employeesController});

  @override
  State<ServiceBoys> createState() => _ServiceBoysState();
}

class _ServiceBoysState extends State<ServiceBoys> {
  late AuthController authController;
  late NewEventController newEventController;
  late EmployeesController employeesController;

  List<EventSiteEmployeeReqModel> empReqlist = [];

  EventSiteEmployeeReqModel? employeeReqModel = EventSiteEmployeeReqModel(
    charge: '',
    requirementCount: 0,
  );
  List<EmployeesTypesList> serviceItems = [];

  List<EventServiceBoyModel> selectedServices = [];

  ValueNotifier<int> serviceBoysCount = ValueNotifier<int>(0);

  @override
  void initState() {
    // serviceItems.addAll(widget.employeesController.employeeTypesList);
    serviceBoysCount.value = 1;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await employeesController.employeeTypesData(token: authController.accesToken!);
      log(" ??? ${employeesController.employeeTypesList.length}");
      serviceItems.addAll(employeesController.employeeTypesList);
      log("${serviceItems.length}");
      // newEventController.eventModel.eventSiteEmployeeRequirement!.add(employeeReqModel);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    employeesController = context.watch<EmployeesController>();
    authController = context.watch<AuthController>();
    newEventController = context.watch<NewEventController>();
    final kSize = MediaQuery.of(context).size;
    return SizedBox(
      width: kSize.width,
      child: ValueListenableBuilder(
          valueListenable: serviceBoysCount,
          builder: (context, value, child) {
            return Column(
              children: [
                Column(
                  children: List.generate(
                    serviceBoysCount.value,
                    (index) => CustomServiceCounter(
                      label: "",
                      items: serviceItems,
                      countCallBack: (count, total) {
                        if (kDebugMode) {
                          log("$count");
                          log("$total");
                          log("Index .>>> ${index}");
                        }

                        newEventController.eventModel.eventSiteEmployeeRequirement[index].charge = "$total";
                        newEventController.eventModel.eventSiteEmployeeRequirement[index].requirementCount =
                            count;
                        if (kDebugMode) {
                          log("${newEventController.eventModel.eventSiteEmployeeRequirement[index].toJson()}");
                        }
                      },
                      onSelectedEmp: (value) {
                        if (newEventController.eventModel.eventSiteEmployeeRequirement.isEmpty) {
                          newEventController.eventModel.eventSiteEmployeeRequirement.add(employeeReqModel!);
                        } else {
                          newEventController.eventModel.eventSiteEmployeeRequirement[index].employeeType =
                              value.id;
                          if (kDebugMode) {
                            log("${newEventController.eventModel.eventSiteEmployeeRequirement[index].employeeType}");
                          }
                        }
                      },
                    ),
                  ),
                ),
                FooterButton(
                    fillColor: AppColors.transparent,
                    label: "Add +",
                    onTap: () {
                      if (kDebugMode) {
                        log("${serviceBoysCount.value}");
                        log("${serviceItems.length}");
                      }

                      if (serviceBoysCount.value < serviceItems.length) {
                        serviceBoysCount.value++;
                        newEventController.eventModel.eventSiteEmployeeRequirement.add(employeeReqModel!);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Max Limit Reached')),
                        );
                      }
                    })
              ],
            );
          }),
    );
  }

  changeListCount() {}
}
