import 'dart:developer';

import 'package:evantez/src/controller/transaction/new_event/new_event_controller.dart';
import 'package:evantez/src/model/core/models/event/event_service_boys/event_service_boys_model.dart';
import 'package:evantez/src/model/core/models/event/event_site_emp_requirement/event_site_emp_req_model.dart';
import 'package:evantez/src/model/core/models/event/new_event_model/new_event_model.dart';
import 'package:evantez/src/serializer/models/employee/employee_types_response.dart';
import 'package:evantez/src/view/view/admin/transactions/new_event/widgets/custom_service_counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/themes/colors.dart';
import '../../../../../core/widgets/footer_button.dart';

class ServiceBoys extends StatefulWidget {
  final List<EmployeesTypesList> items;
  final Function(List<EmployeesTypesList>) onSelected;
  const ServiceBoys({super.key, required this.items, required this.onSelected});

  @override
  State<ServiceBoys> createState() => _ServiceBoysState();
}

class _ServiceBoysState extends State<ServiceBoys> {
  late NewEventController newEventController;

  EventSiteEmployeeReqModel employeeReqModel = EventSiteEmployeeReqModel(
    charge: '',
    employeeType: 0,
    eventSite: 0,
    id: 0,
    requirementCount: 0,
  );
  List<EmployeesTypesList> serviceItems = [];

  List<EventServiceBoyModel> selectedServices = [];

  ValueNotifier<int> serviceBoysCount = ValueNotifier<int>(0);

  @override
  void initState() {
    serviceItems.addAll(widget.items);
    log(" Service Items >>> ${serviceItems.length}");
    serviceBoysCount.value = 1;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // initData();
      newEventController.eventModel!.eventSiteEmployeeRequirement.add(employeeReqModel);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        log("$count");
                        log("$total");
                        newEventController.eventModel!.eventSiteEmployeeRequirement[index].charge = "$total";
                        newEventController.eventModel!.eventSiteEmployeeRequirement[index].requirementCount =
                            count;
                        log("${newEventController.eventModel!.eventSiteEmployeeRequirement[index].toJson()}");
                      },
                      onSelectedEmp: (value) {
                        newEventController.eventModel!.eventSiteEmployeeRequirement[index].employeeType =
                            value.id;
                      },
                    ),
                  ),
                ),
                FooterButton(
                    fillColor: AppColors.transparent,
                    label: "Add +",
                    onTap: () {
                      log("${serviceBoysCount.value}");
                      log("${serviceItems.length}");
                      // if (serviceBoysCount.value <= serviceItems.length) {
                      // widget.onSelected(serviceItems);
                      if (serviceBoysCount.value < serviceItems.length) {
                        serviceBoysCount.value++;
                        newEventController.eventModel!.eventSiteEmployeeRequirement.add(employeeReqModel);
                        // widget.onSelected();
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
