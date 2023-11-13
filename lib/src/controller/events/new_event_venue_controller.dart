import 'dart:io';

import 'package:dio/dio.dart';
import 'package:evantez/src/providers/dashboard/events_provider.dart';
import 'package:evantez/src/serializer/models/event_model.dart';
import 'package:evantez/src/serializer/models/event_response.dart';
import 'package:flutter/material.dart';

class EventVenueController extends ChangeNotifier {
  final GlobalKey<FormState> eventVenueForm = GlobalKey<FormState>();

  TextEditingController eventVenue = TextEditingController();

  File? _eventImage;
  File? get eventImage => _eventImage;
  set eventImage(File? val) {
    if (val != null) {
      _eventImage = val;
    }
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  //event Venue validators
  String? eventVenueValidator(String? value) {
    if (value!.isEmpty) {
      return "Event Venue Required..";
    } else {
      return null;
    }
  }

  void intiLoading() {
    eventImage = null;
    eventVenue.clear();
  }

  List<EventsVenue> eventVenues = [];
  Future getEventVenueList({required String token}) async {
    try {
      final response = await EventProvider().loadEventVenue(token);
      if (response.results!.isNotEmpty) {
        eventVenues = response.results!;
        notifyListeners();
      }
    } catch (_) {}
  }

  Future<EventVenue> addEventvenue({
    required String token,
    required FormData data,
  }) async {
    try {
      isLoading = true;
      final response = await EventProvider().addEventVenue(token: token, data: data);
      isLoading = false;
      notifyListeners();
      return EventVenue.fromJson(response);
    } catch (e) {
      return EventVenue();
    }
  }
}
