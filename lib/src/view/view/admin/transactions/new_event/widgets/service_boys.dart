import 'dart:developer';

import 'package:evantez/src/controller/events/add_event_controller.dart';
import 'package:evantez/src/model/core/models/event/event_service_boys/event_service_boys_model.dart';
import 'package:evantez/src/model/core/models/event/event_site_emp_requirement/event_site_emp_req_model.dart';
import 'package:evantez/src/model/core/models/event_site/event_site_model.dart';

import 'package:evantez/src/serializer/models/employee/employee_types_response.dart';
import 'package:evantez/src/view/view/admin/transactions/new_event/widgets/custom_service_counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../model/core/models/event/event_type/event_type_model.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/widgets/footer_button.dart';

class ServiceBoys extends StatefulWidget {
  final List<EmployeesTypesList> items;
  // final Function(List<EventSiteEmployeeReqModel>) onSelected;
  const ServiceBoys({super.key, required this.items});

  @override
  State<ServiceBoys> createState() => _ServiceBoysState();
}

class _ServiceBoysState extends State<ServiceBoys> {
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
    serviceItems.addAll(widget.items);
    serviceBoysCount.value = 1;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addEventController = context.watch<AddEventController>();
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
                    addEventController.event.eventSiteEmployeeRequirement!.length,
                    (index) => CustomServiceCounter(
                      label: "",
                      items: serviceItems,
                      employeeRequirement: addEventController.event.eventSiteEmployeeRequirement![index],
                      countCallBack: (count, total) {
                        log("$count");
                        log("$total");
                        addEventController.event.eventSiteEmployeeRequirement![index].requirementCount =
                            count;
                        addEventController.event.eventSiteEmployeeRequirement![index].charge = "$total";

                        log("${addEventController.event.eventSiteEmployeeRequirement![index].toJson()}");
                      },
                      onSelectedEmp: (employeeType) {
                        addEventController.event.eventSiteEmployeeRequirement![index].employeeType =
                            employeeType.id;

                        log("${employeeType.toJson()}");
                        log("${addEventController.event.eventSiteEmployeeRequirement![index].toJson()}");
                      },
                    ),
                  ),
                ),
                FooterButton(
                    fillColor: AppColors.transparent,
                    label: "Add +",
                    onTap: () {
                      if (serviceBoysCount.value < serviceItems.length) {
                        serviceBoysCount.value++;
                        addEventController.event.eventSiteEmployeeRequirement!.add(EventSiteEmployeeReqModel(
                          charge: '',
                          employeeType: 0,
                          requirementCount: 0,
                          eventSite: 0,
                          id: 0,
                        ));
                        log(" list count >>> ${addEventController.event.eventSiteEmployeeRequirement!.length}");
                        // newEventController.eventModel.eventSiteEmployeeRequirement!.add(employeeReqModel!);
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
