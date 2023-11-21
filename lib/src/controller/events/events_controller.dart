import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:evantez/app/app.dart';
import 'package:evantez/src/model/components/snackbar_widget.dart';
import 'package:evantez/src/model/core/models/event/event_site_emp_requirement/event_site_emp_req_model.dart';
import 'package:evantez/src/model/core/models/event/event_site_settings/event_site_settings_model.dart';
import 'package:evantez/src/model/core/models/event/new_event_model/new_event_model.dart';
import 'package:evantez/src/model/core/models/event_site/event_site_model.dart';
import 'package:evantez/src/providers/dashboard/events_provider.dart';
import 'package:evantez/src/serializer/models/event_details.response.dart';
import 'package:evantez/src/serializer/models/event_response.dart';
import 'package:flutter/material.dart';

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
      List<InputEventSiteEmployeeReqModel> empList = [];
      if (eventSite.eventSiteEmployeeRequirement!.isNotEmpty) {
        for (var empType in eventSite.eventSiteEmployeeRequirement!) {
          empList.add(InputEventSiteEmployeeReqModel(
            charge: empType.charge,
            eventSite: empType.eventSite,
            id: empType.id,
            employeeType: empType.employeeType!.id,
            requirementCount: empType.requirementCount,
          ));
        }
      } else {
        empList.add(InputEventSiteEmployeeReqModel(
          charge: '',
          employeeType: 0,
          eventSite: eventSite.id,
          id: 0,
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
          // scheduleDateTime: '',
          code: eventSite.code);
      if (eventSite.eventSiteSettings!.isNotEmpty) {
        for (var settings in eventSite.eventSiteSettings!) {
          event.eventSiteSettings!.add(InputEventSiteSettingsModel(
            eventSite: settings.eventSite,
            id: settings.id,
            service: settings.service.id,
          ));
        }
      }

      final response = await EventProvider().changeStatus(token, event, id);
      if (response) {
        await eventsDetails(token: token, id: id);
        rootScaffoldMessengerKey.currentState!
            .showSnackBar(snackBarWidget('Event Updated!', color: Colors.green));
        await Future.delayed(const Duration(seconds: 2));
      } else {
        rootScaffoldMessengerKey.currentState!
            .showSnackBar(snackBarWidget('Event update failed!', color: Colors.red));
        await Future.delayed(const Duration(seconds: 2));
      }
    } catch (_) {}
  }

  EventSiteModel? eventModel;
  Future getEventDetail({required String token, required int eventId}) async {
    try {
      final response = await EventProvider().getEventDetail(token, eventId);
      eventModel = response;
      selectedeventStatus.value = getEventStatusString(eventModel!.status!);
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
}
