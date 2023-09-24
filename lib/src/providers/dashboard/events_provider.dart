import 'dart:io';

import 'package:dio/dio.dart';
import 'package:evantez/src/model/core/base_api_utilities.dart';
import 'package:evantez/src/serializer/models/event_details.response.dart';
import 'package:evantez/src/serializer/models/event_response.dart';
import 'package:evantez/src/view/core/event_api.dart';

import '../../serializer/models/event_site_model.dart';

class EventProvider extends EventApi {
  //=-=-=-=-=-=-=-=-= Events =-=-=-=-=-=-=-=-=-=
  Future<EventsResponse> loadEvents(String token) async {
    Response response =
        await get('events/event-venue/', headers: apiHeaders(token));

    switch (response.statusCode) {
      case 200:
        return EventsResponse.fromJson(response.data);

      default:
        throw Exception('Error');
    }
  }

  //=-=-=-=-=-=-==-=-= Events Details =-=-=-=-=-=-=
  Future<EventsDetailResponse> loadEventDetails(
      {required String token, required int id}) async {
    Response response =
        await get('events/event-venue/$id', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
        return EventsDetailResponse.fromJson(response.data);
      default:
        throw Exception('Error');
    }
  }

  //-=-=-=-=-=-=-=-=-=  Event Type -=-=-=-=-=-=-
  Future addEventType({required String token, required String eventadd}) async {
    Response response = await post('events/event-type/',
        headers: apiHeaders(token), data: {'name': '$eventadd'});
    switch (response.statusCode) {
      case 201:
        return response.data;
      default:
        throw Exception('Error');
    }
  }

//-=-=-=-=-=-=--== Event Venue -=-=-=-=-==-===-=
  Future<dynamic> AddEventVenue({
    required String token,
    required FormData data,
  }) async {
    Response response = await post('events/event-venue/',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'multipart/form-data'
        },
        data: data
        // {
        //   // "name": name,
        //   // "image": image,
        //   // "lat": lat,
        //   // "log": log
        // }
        );
    switch (response.statusCode) {
      case 201:
        return response.data;
      default:
        throw Exception('Error');
    }
  }
// -=-=-=-=-=-=-= Employee type =-=-=-=-=-=-=-=-=

  Future<dynamic> EmpType({
    required String token,
    required String name,
    required String code,
    required int amount,
  }) async {
    Response response = await post('users/employee-type/',
        headers: apiHeaders(token),
        data: {"name": name, "code": code, "amount": amount});
    switch (response.statusCode) {
      case 201:
        return response.data;
      default:
        throw Exception('Error');
    }
  }

// -=-=-=-=-=-=-= Event Site -=-=-=-=-=-=-=-=-=-=

  Future<dynamic> EventSiteAdd(
      {required String token, required EventSite eventSite}) async {
    Response response = await post('events/event-site/',
        headers: apiHeaders(token), data: eventSite.toJson());
    switch (response.statusCode) {
      case 201:
        return response.data;
      default:
        throw Exception('Error');
    }
  }
}
