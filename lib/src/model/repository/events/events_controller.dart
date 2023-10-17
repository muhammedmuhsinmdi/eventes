import 'dart:io';

import 'package:dio/dio.dart';
import 'package:evantez/src/providers/dashboard/events_provider.dart';
import 'package:evantez/src/serializer/models/event_details.response.dart';
import 'package:evantez/src/serializer/models/event_response.dart';
import 'package:flutter/material.dart';

import '../../../serializer/models/event_model.dart';
import '../../../serializer/models/event_site_model.dart';

class EventController extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

//=-=-=-==-=-=-=-=-=-= Events =-=-=-=-=-=-=-=-=-=-=
  List<EventsList> eventList = [];
  Future<void> events(String token) async {
    try {
      isLoading = true;
      final response = await EventProvider().loadEvents(token);
      if (response.results?.isNotEmpty ?? false) {
        eventList = response.results ?? [];
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
      final response =
          await EventProvider().loadEventDetails(token: token, id: id);
      eventsDetail = response;
      notifyListeners();
      isLoading = false;
    } catch (e) {
      isLoading = false;
    }
  }

  // -=-=-=-=-=-=-=-=-=-=- Event Type =--=-=-=-=-=-===---=--=
  Future<Eventtype> addEventType(
      {required String token, required String eventadd}) async {
    try {
      final response =
          await EventProvider().addEventType(token: token, eventadd: eventadd);

      return Eventtype.fromJson(response);
    } catch (e) {
      return Eventtype();
    }
  }

// -=-=-=-=-=-=-=-=== Event Venue -=-=-=-=-=-=-=-=-=-=-=--=-=

  Future<EventVenue> addEventvenue(
      {required String token,
      
      required FormData data,
   }) async {
   
    try {
      final response = await EventProvider().AddEventVenue(
          token: token, data: data);

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
      final response = await EventProvider()
          .EmpType(token: token, name: name, code: code, amount: amount);

      return EmpType.fromJson(response);
    } catch (e) {
      return EmpType();
    }
  }

  // -=-=-=-=-=-=-= Event Site -=-=-=-=-=-=-=-=-=-=

  Future<EventSite> eventSiteAdd(
      {required String token, required EventSite eventSite}) async {
    try {
      final response = await EventProvider()
          .EventSiteAdd(token: token, eventSite: eventSite);

      return EventSite.fromJson(response);
    } catch (e) {
      return EventSite();
    }
  }
}
