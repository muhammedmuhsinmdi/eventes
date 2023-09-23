import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:evantez/src/providers/dashboard/events_provider.dart';
import 'package:evantez/src/serializer/models/event_details.response.dart';
import 'package:evantez/src/serializer/models/event_response.dart';
import 'package:flutter/material.dart';

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
        eventList.sort((a, b) {
          if (a.updatedAt != null && b.updatedAt != null) {
            return b.updatedAt!.compareTo(a.updatedAt!); // Sort by updatedAt if both are not null
          } else if (a.updatedAt != null) {
            return -1; // a comes before b if only a has updatedAt
          } else if (b.updatedAt != null) {
            return 1; // b comes before a if only b has updatedAt
          } else {
            return a.createdAt!.compareTo(b.createdAt!); // Sort by createdAt if both are null
          }
        });
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
}
