import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:evantez/app/app.dart';
import 'package:evantez/src/model/components/snackbar_widget.dart';
import 'package:evantez/src/model/core/models/employee/assing_event_employee.dart';
import 'package:evantez/src/model/core/models/event/new_event_model/new_event_model.dart';
import 'package:evantez/src/model/core/models/event/output_model/event_emp_req_model.dart';
import 'package:evantez/src/model/core/models/event_site/event_site_model.dart';
import 'package:evantez/src/providers/dashboard/events_provider.dart';
import 'package:evantez/src/providers/resources/employee_type/employee_type_viewstate.dart';
import 'package:evantez/src/serializer/models/employee/employee_list_response.dart';
import 'package:evantez/src/serializer/models/employee/employee_types_response.dart';
import 'package:evantez/src/serializer/models/event_details.response.dart';
import 'package:evantez/src/serializer/models/event_response.dart';
import 'package:evantez/src/view/core/themes/colors.dart';
import 'package:evantez/src/view/core/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../serializer/models/event_model.dart';
import '../../serializer/models/event_site_model.dart';

class EventController extends ChangeNotifier {
  bool _isLoading = false;

  final ValueNotifier<String> selectedeventStatus = ValueNotifier<String>('');

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  TextEditingController scheduledDate = TextEditingController();
  TextEditingController scheduledTime = TextEditingController();

//=-=-=-==-=-=-=-=-=-= Events =-=-=-=-=-=-=-=-=-=-=
  List<EventSiteModel> eventList = [];
  Future<void> events(String token) async {
    try {
      isLoading = true;
      final response = await EventProvider().loadEvents(token);
      log(" event list >>>>. ${response.length}");
      if (response.isNotEmpty) {
        eventList = response;
        notifyListeners();
      }
      isLoading = false;
    } catch (e) {
      log("$e");
      isLoading = false;
    }
  }

  String getEventStatus(String status) {
    switch (status) {
      case "Upcoming - Hold":
        return 'hold';
      case "Upcoming - Open":
        return "open";
      case "Upcoming - Filled":
        return "filled";
      case "Ongoing":
        return "ongoing";
      case "Settlement":
        return "settlement";
      case "Completed":
        return "completed";
      default:
        return '';
    }
  }

  // Event Venues
  List<EventsVenue> eventVenues = [];
  Future<void> getEventVenues(String token) async {
    try {
      isLoading = true;
      final response = await EventProvider().loadEventVenue(token);
      log("${response.results!.length}");
      if (response.results!.isNotEmpty) {
        eventVenues = response.results!;
        notifyListeners();
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
    }
  }

  //=-=-=-=-=-=-=-=-=-= Events Details =-=-=-==-=--=-=-=-=
  EventsDetailResponse? eventsDetail;
  Future<void> eventsDetails({required String token, required int id}) async {
    try {
      isLoading = true;
      final response = await EventProvider().loadEventDetails(token: token, id: id);
      eventsDetail = response;
      log("${eventsDetail!.toJson()}");
      notifyListeners();
      isLoading = false;
    } catch (e) {
      isLoading = false;
    }
  }

  // -=-=-=-=-=-=-=-=-=-=- Event Type =--=-=-=-=-=-===---=--=
  Future<Eventtype> addEventType({required String token, required String eventadd}) async {
    try {
      final response = await EventProvider().addEventType(token: token, eventadd: eventadd);

      return Eventtype.fromJson(response);
    } catch (e) {
      return Eventtype();
    }
  }

// -=-=-=-=-=-=-=-=== Event Venue -=-=-=-=-=-=-=-=-=-=-=--=-=

  Future<EventVenue> addEventvenue({
    required String token,
    required FormData data,
  }) async {
    try {
      final response = await EventProvider().addEventVenue(token: token, data: data);

      return EventVenue.fromJson(response);
    } catch (e) {
      return EventVenue();
    }
  }

  //-=-=-=-=-=-=--=-=-=--=-=- Employee Type -=-=-=-=-=-=-=-=-=

  Future<EmpType> employeeType({
    required String token,
    required String name,
    required String code,
    required int amount,
  }) async {
    try {
      final response = await EventProvider().EmpType(token: token, name: name, code: code, amount: amount);

      return EmpType.fromJson(response);
    } catch (e) {
      return EmpType();
    }
  }

  // -=-=-=-=-=-=-= Event Site -=-=-=-=-=-=-=-=-=-=

  Future<EventSite> eventSiteAdd({required String token, required NewEventModel eventSite}) async {
    try {
      final response = await EventProvider().eventSiteAdd(token: token, eventSite: eventSite);

      return EventSite.fromJson(response);
    } catch (e) {
      return EventSite();
    }
  }

  /*  Future updateEventVenue(String token, int venueId) async {
    try {
      final response = await EventProvider().updateEventVenue(token, venueId);
    } catch (_) {}
  } */

  Future deleteEvent({required String token, required int eventId}) async {
    try {
      final response = await EventProvider().deleteEvent(token, eventId);
      if (response == 204) {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  // Change Event Status
  Future updateEvent({required String token, required int id, required EventSiteModel eventSite}) async {
    try {
      List<EventSiteEmployeeRequirement> empList = [];
      if (eventSite.eventSiteEmployeeRequirement!.isNotEmpty) {
        for (var empType in eventSite.eventSiteEmployeeRequirement!) {
          empList.add(EventSiteEmployeeRequirement(
            charge: empType.charge,
            employeeType: empType.employeeType!.id,
            requirementCount: empType.requirementCount,
          ));
        }
      } else {
        empList.add(EventSiteEmployeeRequirement(
          charge: '',
          employeeType: 0,
          requirementCount: 0,
        ));
      }

      NewEventModel event = NewEventModel(
        customerAddress: eventSite.customerAddress,
        customerName: eventSite.customerName,
        customerPhone: eventSite.customerPhone,
        eventSiteEmployeeRequirement: empList,
        eventSiteSettings: [],
        eventTypeId: eventSite.eventType!.id,
        normalHours: eventSite.normalHours,
        notes: eventSite.notes,
        overtimeHourlyCharge: eventSite.overtimeHourlyCharge,
        status: eventSite.status,
        venueId: eventSite.venue!.id,
      );
      if (eventSite.eventSiteSettings!.isNotEmpty) {
        for (var settings in eventSite.eventSiteSettings!) {
          event.eventSiteSettings!.add(EventSiteSetting(
            service: settings.service.id,
          ));
        }
      }

      final response = await EventProvider().changeStatus(token, event, id);
      if (response != null) {
        await eventsDetails(token: token, id: id);
        rootScaffoldMessengerKey.currentState!
            .showSnackBar(snackBarWidget('Event Updated!', color: Colors.green));
        await Future.delayed(const Duration(seconds: 2));
        return true;
      } else {
        rootScaffoldMessengerKey.currentState!
            .showSnackBar(snackBarWidget('Event update failed!', color: Colors.red));
        await Future.delayed(const Duration(seconds: 2));
        return false;
      }
    } catch (_) {}
  }

  EventSiteModel? eventModel;
  Future getEventDetail({required String token, required int eventId}) async {
    try {
      final response = await EventProvider().getEventDetail(token, eventId);
      eventModel = response;
      for (var requiurement in eventModel!.eventSiteEmployeeRequirement!) {
        requiurement.assignedEmployeeList = [];
      }
      scheduledDate.text = DateFormat("dd MMM, yyyy").format(eventModel!.scheduledDatetime!);
      scheduledTime.text = DateFormat('hh:mm a').format(eventModel!.scheduledDatetime!);
      selectedeventStatus.value = getEventStatusString(eventModel!.status!);
      await getEmployeeList(token);
      await getAddedEmployeeList(token);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  String getEventStatusString(String status) {
    switch (status) {
      case "hold":
        return 'Upcoming - Hold';
      case "open":
        return "Upcoming - Open";
      case "filled":
        return "Upcoming - Filled";
      case "ongoing":
        return "Ongoing";
      case "settlement":
        return "Settlement";
      case "completed":
        return "Completed";
      default:
        return '';
    }
  }

  Color getEventStatusColor(String status) {
    switch (status) {
      case "Upcoming - Hold":
        return AppColors.statusCritical;
      case "Upcoming - Open":
        return AppColors.statusSuccess;
      case "Upcoming - Filled":
        return AppColors.statusWarning;
      case "Ongoing":
        return AppColors.statusSuccess;
      case "Settlement":
        return AppColors.statusBlue;
      case "Completed":
        return AppColors.statusPending;
      default:
        return AppColors.transparent;
    }
  }

  Future addEmployee({required String token, required EventAssignEmployee assignedEmp}) async {
    try {
      // check selected employe -> employee type
      var requirement = eventModel!.eventSiteEmployeeRequirement!
          .firstWhere((element) => element.employeeType!.id == assignedEmp.employee!.employeeType);
      if (requirement != null) {
        var existEmployee = requirement.assignedEmployeeList!
            .firstWhere((element) => element.employee!.id == assignedEmp.employee!.id);
        if (existEmployee == null) {
          if (requirement.assignedEmployeeList!.length < requirement!.requirementCount!) {
            final response = await EventProvider().addEventEmployee(
              token: token,
              model: assignedEmp,
            );
            if (response != null) {
              requirement.assignedEmployeeList!.add(assignedEmp);
              return response;
            }
          } else {
            String message = "${requirement.employeeType!.name} exceeded";
            rootScaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
              content: Text(
                message,
                style: AppTypography.poppinsMedium.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
              backgroundColor: AppColors.statusCritical,
            ));
            // employee
          }
        } else {
          String message = "${assignedEmp.employee!.employeeName} already added";
          rootScaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
            content: Text(
              message,
              style: AppTypography.poppinsMedium.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
            backgroundColor: AppColors.statusCritical,
          ));
        }
      } else {
        // selected employee not required in this event
        String message = "Selected Employee not required!";
        rootScaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
          content: Text(
            message,
            style: AppTypography.poppinsMedium.copyWith(
              color: AppColors.secondaryColor,
            ),
          ),
          backgroundColor: AppColors.statusCritical,
        ));
      }
    } catch (e) {
      log("$e");
    }
  }

  List<EmployeeListResponse> employeeList = [];
  Future<void> getEmployeeList(String token) async {
    try {
      employeeList = await EmployeeProvider().loadEmployee(token: token);
      log("EmployeeList Count >>> ${employeeList.length}");
    } catch (e) {
      log("$e");
    }
  }

  List<EmployeesTypesList> employeeTypeList = [];
  Future<void> getEmployeeTypeList(String token) async {
    try {
      var employeeTypes = await EmployeeProvider().loadEmployeesTypes(token: token);

      eventModel!.eventSiteEmployeeRequirement!.forEach((req) {
        EmployeesTypesList empType = employeeTypes.firstWhere((type) => type.id == req.employeeType!.id);
        req.employeeType!.id = empType.id;
        req.employeeType!.name = empType.name!;
      });
    } catch (_) {}
  }

  List<EventAssignEmployee> addedEmployees = [];
  Future<void> getAddedEmployeeList(String token) async {
    try {
      addedEmployees = [];
      List<EventAssignEmployee> response = await EventProvider().getAddedEmplyeeList(token, eventModel!.id!);
      if (response.isNotEmpty) {
        addedEmployees.addAll(response);

        for (var req in eventModel!.eventSiteEmployeeRequirement!) {
          var addedEmps = addedEmployees
              .where((element) => element.employee!.employeeType == req.employeeType!.id)
              .toList();
          req.assignedEmployeeList = addedEmps;
        }
      }
    } catch (e) {
      log("${e}");
    }
  }

  Color getSlotColor(int requirment, int added) {
    Color retColor = AppColors.statusCritical;

    if (requirment < added) {
      retColor = AppColors.statusSuccess;
    }
    return retColor;
  }

  // Make Captain Function
  Future makeEmployeeCaptain(EventAssignEmployee data, String token) async {
    try {
      Response response = await EventProvider().setCaptain(data, eventModel!.id!, token);
      if (response.statusCode == 200) {
        rootScaffoldMessengerKey.currentState!
            .showSnackBar(snackBarWidget('Employee set as Captain!', color: Colors.green));
        getEventDetail(token: token, eventId: eventModel!.id!);
      } else {
        rootScaffoldMessengerKey.currentState!
            .showSnackBar(snackBarWidget('Unable to set Captain', color: Colors.red));
      }
    } catch (_) {}
  }

  Future deleteAssignedEmployee(int employeeId, String token) async {
    try {
      Response response = await EventProvider().deleteAssignedEmployee(employeeId, eventModel!.id!, token);
      if (response.statusCode == 204) {
        rootScaffoldMessengerKey.currentState!
            .showSnackBar(snackBarWidget('Employee Deleted Successfully!', color: Colors.green));
        getEventDetail(token: token, eventId: eventModel!.id!);
      } else {
        rootScaffoldMessengerKey.currentState!
            .showSnackBar(snackBarWidget('Employee delete failed!', color: Colors.red));
      }
    } catch (_) {}
  }
}
