import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:evantez/src/model/core/base_api_utilities.dart';
import 'package:evantez/src/model/core/models/event/event_type/event_type_model.dart';
import 'package:evantez/src/model/core/models/event/new_event_model/new_event_model.dart';
import 'package:evantez/src/model/core/models/event_site/event_site_model.dart';
import 'package:evantez/src/serializer/models/event_details.response.dart';
import 'package:evantez/src/serializer/models/event_response.dart';
import 'package:evantez/src/view/core/event_api.dart';

class EventProvider extends EventApi {
  //=-=-=-=-=-=-=-=-= Events =-=-=-=-=-=-=-=-=-=
  Future<List<EventSiteModel>> loadEvents(String token) async {
    Response response = await get('events/event-site/', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
        return (response.data['results'] as List).map((e) => EventSiteModel.fromJson(e)).toList();
      default:
        throw Exception('Error');
    }
  }

  Future<EventsResponse> loadEventVenue(String token) async {
    Response response = await get('events/event-venue/', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
        return EventsResponse.fromJson(response.data);
      default:
        throw Exception('Error');
    }
  }

  //=-=-=-=-=-=-==-=-= Events Details =-=-=-=-=-=-=
  Future<EventsDetailResponse> loadEventDetails({required String token, required int id}) async {
    Response response = await get('events/event-site/$id', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
        return EventsDetailResponse.fromJson(response.data);
      default:
        throw Exception('Error');
    }
  }

  //-=-=-=-=-=-=-=-=-=  Event Type -=-=-=-=-=-=-
  Future addEventType({required String token, required String eventadd}) async {
    Response response =
        await post('events/event-type/', headers: apiHeaders(token), data: {'name': '$eventadd'});
    switch (response.statusCode) {
      case 201:
        return response.data;
      default:
        throw Exception('Error');
    }
  }

//-=-=-=-=-=-=--== Event Venue -=-=-=-=-==-===-=
  Future<dynamic> addEventVenue({
    required String token,
    required FormData data,
  }) async {
    try {
      Response response = await post('events/event-venue/',
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'multipart/form-data'
          },
          data: data);
      log("${response.statusCode}");
      log("${response.data}");
      switch (response.statusCode) {
        case 201:
          return response.data;
        default:
          throw Exception('Error');
      }
    } catch (_) {}
  }
// -=-=-=-=-=-=-= Employee type =-=-=-=-=-=-=-=-=

  Future<dynamic> EmpType({
    required String token,
    required String name,
    required String code,
    required int amount,
  }) async {
    Response response = await post('users/employee-type/',
        headers: apiHeaders(token), data: {"name": name, "code": code, "amount": amount});
    switch (response.statusCode) {
      case 201:
        return response.data;
      default:
        throw Exception('Error');
    }
  }

// -=-=-=-=-=-=-= Event Site -=-=-=-=-=-=-=-=-=-=

  Future<dynamic> eventSiteAdd({required String token, required NewEventModel eventSite}) async {
    var postData = json.encode(eventSite.toJson());
    log(postData);
    Response response = await post('events/event-site/', headers: apiHeaders(token), data: postData);
    log("${response.statusCode}");
    log('${response.data}');
    switch (response.statusCode) {
      case 201:
        return true;
      default:
        throw Exception('Error');
    }
  }

  // Update Event Site
  Future<dynamic> updateEventSite(
      {required String token, required int eventId, required NewEventModel eventSite}) async {
    log("token >>>>  $token");
    log('PUT METHOD');
    try {
      var postData = json.encode(eventSite.toJson());
      log(postData);
      Response response = await put("events/event-site/$eventId/",
          queryParameters: {}, headers: apiHeaders(token), data: postData);
      switch (response.statusCode) {
        case 200:
          return true;
        default:
          return false;
      }
    } catch (e) {
      log("$e");
    }
  }

// -=-=-=-=-=-=-= Event Site -=-=-=-=-=-=-=-=-=-=
  Future<List<EventTypeModel>> getEventTypes({required String token}) async {
    try {
      Response response = await get('events/event-type/', headers: apiHeaders(token));
      switch (response.statusCode) {
        case 200:
          return (response.data['results'] as List).map((e) => EventTypeModel.fromJson(e)).toList();

        default:
          throw Exception('Error');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<EventSiteModel> getEventDetail(String token, int id) async {
    try {
      Response response = await get("events/event-site/$id/", headers: apiHeaders(token));
      log("${response.statusCode}");
      log("${response.data}");
      return EventSiteModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
