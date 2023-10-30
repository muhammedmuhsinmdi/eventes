import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:evantez/src/model/core/models/event/event_type/event_type_model.dart';
import 'package:evantez/src/model/core/models/event/event_venue/event_venue_model.dart';
import 'package:evantez/src/model/core/models/event/new_event_model/new_event_model.dart';
import 'package:evantez/src/providers/dashboard/events_provider.dart';
import 'package:evantez/src/serializer/models/event_model.dart';
import 'package:flutter/material.dart';

class NewEventController extends ChangeNotifier {
  TextEditingController eventVenue = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController customerPhone = TextEditingController();
  TextEditingController customerAddress = TextEditingController();
  TextEditingController additionalInfo = TextEditingController();
  TextEditingController normalHours = TextEditingController();
  TextEditingController overTimeRate = TextEditingController();
  TextEditingController scheduledDate = TextEditingController();
  TextEditingController scheduledTime = TextEditingController();

  EventTypeModel? eventType;
  EventVenueModel? eventVenueValue;

  NewEventModel eventModel = NewEventModel(
      eventSiteSettings: [],
      eventSiteEmployeeRequirement: [],
      eventTypeId: 0,
      venueId: 0,
      code: '',
      customerName: '',
      customerAddress: '',
      customerPhone: '',
      notes: '',
      normalHours: '',
      overtimeHourlyCharge: '',
      status: '');

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  String _eventTypeString = '';
  String get eventTypeString => _eventTypeString;
  set eventTypeString(String value) {
    _eventTypeString = value;
    notifyListeners();
  }

  List<EventTypeModel> _eventTypeList = [];
  List<EventTypeModel> get eventTypeList => _eventTypeList;
  set eventTypeList(List<EventTypeModel> val) {
    _eventTypeList = val;
  }

  initData() {
    eventModel = NewEventModel(
      code: "",
      customerAddress: '',
      customerName: '',
      customerPhone: '',
      eventSiteEmployeeRequirement: [],
      eventSiteSettings: [],
      eventTypeId: 0,
      normalHours: '',
      notes: '',
      overtimeHourlyCharge: '',
      status: '',
      venueId: 0,
    );
  }

  Future getEventTypes(String token) async {
    try {
      final response = await EventProvider().getEventTypes(token: token);
      if (response.isNotEmpty) {
        eventTypeList = response;
        notifyListeners();
      }
    } catch (e) {
      eventTypeList = [];
    }
  }

  // -=-=-=-=-=-=-=-=== Event Venue -=-=-=-=-=-=-=-=-=-=-=--=-=

  Future<EventVenue> addEventvenue({
    required String token,
    required FormData data,
  }) async {
    try {
      log("${data.fields}");
      final response = await EventProvider().addEventVenue(token: token, data: data);
      log("${response}");
      return EventVenue.fromJson(response);
    } catch (e) {
      return EventVenue();
    }
  }

  Future addEventSite({
    required String token,
  }) async {
    try {
      eventModel!.eventSiteEmployeeRequirement = [];
      eventModel!.eventSiteSettings = [];
      log("${eventModel!.toJson()}");
      final response = await EventProvider().eventSiteAdd(token: token, eventSite: eventModel!);
      // log("${response.}");
    } catch (_) {}
  }
}
