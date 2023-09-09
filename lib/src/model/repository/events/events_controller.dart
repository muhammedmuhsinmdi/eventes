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
