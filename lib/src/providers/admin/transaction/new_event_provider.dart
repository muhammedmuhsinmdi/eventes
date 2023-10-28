import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:evantez/src/model/core/app_prefs/app_prefs.dart';
import 'package:evantez/src/model/core/base_api_utilities.dart';
import 'package:evantez/src/model/core/models/event/event_type/event_type_model.dart';
import 'package:evantez/src/model/core/models/event/event_venue/event_venue_model.dart';
import 'package:evantez/src/view/core/event_api.dart';

class NewEventProvider extends EventApi {
  // -=-=-=-=-=-=-= Event Site -=-=-=-=-=-=-=-=-=-=
  Future<EventTypeModel> getEventTypes({required String token}) async {
    Response response = await get('events/event-type/', headers: apiHeaders(token));
    log("${response.statusCode}");
    switch (response.statusCode) {
      case 201:
        final list = EventTypeModel.fromJson(response.data);
        return list;
      default:
        throw Exception('Error');
    }
  }

  Future<EventVenueModel> getEventVenue() async {
    Response response = await get('events/event-venue/', headers: apiHeaders(AppPrefs.token!));
    log("${response.statusCode}");
    switch (response.statusCode) {
      case 201:
        final list = EventVenueModel.fromJson(response.data);
        return list;
      default:
        throw Exception('Error');
    }
  }


  


   




}
